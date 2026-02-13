function worktree --description 'Create or switch to a git worktree with pnpm install' --argument branch action
    # Validate arguments
    set -q branch[1]; or begin
        echo "Usage: worktree <branch> [cleanup]" >&2
        echo "       worktree list" >&2
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

    # Get the project name from the repo root directory
    set project_name (basename (git rev-parse --show-toplevel))
    set worktree_path "$HOME/Worktrees/$project_name/$branch"

    # Handle cleanup subcommand
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
