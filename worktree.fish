function worktree --description 'Create or switch to a git worktree with pnpm install'
    set -l branch $argv[1]

    # Validate arguments
    set -q branch[1]; or begin
        echo "Usage: worktree <branch> [cleanup]" >&2
        echo "       worktree list" >&2
        echo "       worktree cleanup --merged [--dry-run]" >&2
        return 1
    end

    # Ensure we're in a git repo
    git rev-parse --is-inside-work-tree >/dev/null 2>&1; or begin
        echo "Error: not inside a git repository" >&2
        return 1
    end

    # Handle list subcommand
    if test "$branch" = list
        git worktree list
        return $status
    end

    # Handle cleanup --merged subcommand
    if test "$branch" = cleanup
        set -l merged false
        set -l dry_run false
        for arg in $argv[2..]
            switch $arg
                case --merged
                    set merged true
                case --dry-run
                    set dry_run true
                case '*'
                    echo "Unknown flag: $arg" >&2
                    echo "Usage: worktree cleanup --merged [--dry-run]" >&2
                    return 1
            end
        end

        if test "$merged" = false
            echo "Usage: worktree cleanup --merged [--dry-run]" >&2
            return 1
        end

        set project_name (basename (git rev-parse --show-toplevel))
        set -l repo_root (git rev-parse --show-toplevel)
        set -l cleaned 0

        # Get all worktrees (skip the first line which is the main worktree)
        for line in (git worktree list --porcelain)
            if string match -q "worktree *" $line
                set -l wt_path (string replace "worktree " "" $line)
                # Skip the main worktree
                if test "$wt_path" = "$repo_root"
                    continue
                end
                # Extract branch name from the path
                set -l wt_branch (basename "$wt_path")
                # Check if this branch has a merged PR
                set -l pr_state (gh pr view "$wt_branch" --json state --jq '.state' 2>/dev/null)
                if test "$pr_state" = MERGED
                    if test "$dry_run" = true
                        echo "[dry-run] Would remove worktree for '$wt_branch' (PR merged)"
                    else
                        # Leave the worktree if we're inside it
                        if string match -q "$wt_path*" (pwd)
                            popd 2>/dev/null; or cd "$repo_root"
                        end
                        git worktree remove "$wt_path"
                        and echo "Removed worktree for '$wt_branch' (PR merged, branch preserved)"
                    end
                    set cleaned (math $cleaned + 1)
                end
            end
        end

        if test $cleaned -eq 0
            echo "No worktrees with merged PRs found"
        else if test "$dry_run" = true
            echo "$cleaned worktree(s) would be cleaned up"
        else
            echo "$cleaned worktree(s) cleaned up"
        end
        return 0
    end

    set -l action $argv[2]

    # Get the project name from the repo root directory
    set project_name (basename (git rev-parse --show-toplevel))
    set worktree_path "$HOME/Worktrees/$project_name/$branch"

    # Handle <branch> cleanup subcommand
    if test "$action" = cleanup
        if not test -d "$worktree_path"
            echo "No worktree found at $worktree_path" >&2
            return 1
        end
        # If we're inside the worktree, leave it first
        if string match -q "$worktree_path*" (pwd)
            popd 2>/dev/null; or cd (git rev-parse --show-toplevel 2>/dev/null; or echo $HOME)
        end
        git worktree remove "$worktree_path"
        echo "Worktree removed (branch '$branch' preserved)"
        return $status
    end

    # Check if the worktree already exists at that path
    if test -d "$worktree_path"
        echo "Worktree already exists at $worktree_path"
        pushd "$worktree_path"
        return 0
    end

    # Check if the branch exists (local or remote)
    if git show-ref --verify --quiet "refs/heads/$branch"
        # Local branch exists
        git worktree add "$worktree_path" "$branch"
    else if git show-ref --verify --quiet "refs/remotes/origin/$branch"
        # Remote branch exists, track it
        git worktree add "$worktree_path" "$branch"
    else
        # Branch doesn't exist, create it
        git worktree add -b "$branch" "$worktree_path"
    end

    or begin
        echo "Error: failed to create worktree" >&2
        return 1
    end

    pushd "$worktree_path"
    echo "Installing dependencies..."
    pnpm install
end
status is-interactive; or worktree $argv
