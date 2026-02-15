function worktree --description 'Create or switch to a git worktree with pnpm install'
    set -l branch $argv[1]

    # Validate arguments
    set -q branch[1]; or begin
        echo "Usage: worktree <branch> [cleanup]" >&2
        echo "       worktree list" >&2
        echo "       worktree cleanup [--merged [--dry-run]]" >&2
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

    # Handle cleanup subcommand
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
                    echo "Usage: worktree cleanup [--merged [--dry-run]]" >&2
                    return 1
            end
        end

        # No flags: clean up the current worktree
        if test "$merged" = false
            set -l current_wt (pwd)
            # Find the main worktree (the bare/main checkout)
            set -l main_wt ""
            for line in (git worktree list --porcelain)
                if string match -q "worktree *" $line
                    set main_wt (string replace "worktree " "" $line)
                    break
                end
            end
            # Check we're actually in a worktree (not the main checkout)
            if test "$current_wt" = "$main_wt"
                echo "Error: you're in the main worktree, not a linked worktree" >&2
                return 1
            end
            # Verify current dir is a worktree
            set -l found false
            for line in (git worktree list --porcelain)
                if string match -q "worktree $current_wt" $line
                    set found true
                    break
                end
            end
            if test "$found" = false
                echo "Error: current directory is not a worktree root" >&2
                echo "cd to the root of your worktree first" >&2
                return 1
            end
            set -l wt_branch (basename "$current_wt")
            pushd "$main_wt"
            git worktree remove "$current_wt"
            if test $status -ne 0
                echo "Error: failed to remove worktree (unmerged changes?)" >&2
                popd
                return 1
            end
            echo "Worktree removed (branch '$wt_branch' preserved)"
            return 0
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
                            pushd "$repo_root"
                        end
                        git worktree remove "$wt_path"
                        if test $status -ne 0
                            echo "Error: failed to remove worktree for '$wt_branch' (unmerged changes?)" >&2
                            continue
                        end
                        echo "Removed worktree for '$wt_branch' (PR merged, branch preserved)"
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
            pushd (git rev-parse --show-toplevel 2>/dev/null; or echo $HOME)
        end
        git worktree remove "$worktree_path"
        if test $status -ne 0
            echo "Error: failed to remove worktree (unmerged changes?)" >&2
            popd 2>/dev/null
            return 1
        end
        echo "Worktree removed (branch '$branch' preserved)"
        return 0
    end

    # Fetch latest from origin/main
    echo "Fetching latest from origin/main..."
    git fetch origin main

    # Check if the branch is already checked out in any worktree
    set -l existing_wt_path ""
    set -l current_wt ""
    for line in (git worktree list --porcelain)
        if string match -q "worktree *" $line
            set current_wt (string replace "worktree " "" $line)
        else if string match -q "branch refs/heads/$branch" $line
            set existing_wt_path $current_wt
        end
    end

    if test -n "$existing_wt_path"
        echo "Branch '$branch' already checked out at $existing_wt_path"
        pushd "$existing_wt_path"
        echo "Merging latest origin/main..."
        git merge origin/main
        return $status
    end

    # Check if the worktree directory already exists (orphaned)
    if test -d "$worktree_path"
        echo "Worktree directory exists at $worktree_path"
        pushd "$worktree_path"
        echo "Merging latest origin/main..."
        git merge origin/main
        return $status
    end

    # Check if the branch exists (local or remote)
    set -l is_new_branch false
    if git show-ref --verify --quiet "refs/heads/$branch"
        # Local branch exists
        git worktree add "$worktree_path" "$branch"
    else if git show-ref --verify --quiet "refs/remotes/origin/$branch"
        # Remote branch exists, track it
        git worktree add "$worktree_path" "$branch"
    else
        # Branch doesn't exist, create from origin/main
        set is_new_branch true
        git worktree add -b "$branch" "$worktree_path" origin/main
    end

    or begin
        echo "Error: failed to create worktree" >&2
        return 1
    end

    pushd "$worktree_path"

    # Merge latest origin/main into existing branches (skip for new branches already based on origin/main)
    if test "$is_new_branch" = false
        echo "Merging latest origin/main..."
        git merge origin/main
        or begin
            echo "Warning: merge conflict with origin/main — resolve before continuing" >&2
            return 1
        end
    end

    echo "Installing dependencies..."
    pnpm install
end
status is-interactive; or worktree $argv
