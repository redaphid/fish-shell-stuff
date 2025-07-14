#!/usr/bin/env fish
function ov --description 'Manage overlay git repositories stored in ~/.ov/repo/<repo_name>' --argument repo_name
    # Handle special commands
    switch "$repo_name"
        case "list"
            echo "Overlay repositories:"
            if test -d "$HOME/.ov/repo"
                for repo in "$HOME/.ov/repo"/*
                    if test -d "$repo"
                        set repo_name (basename "$repo")
                        echo "  $repo_name"
                    end
                end
            else
                echo "  (none found - use 'ov-setup <repo-name> <git-url>' to create)"
            end
            return 0
        case "delete"
            set target_repo "$argv[2]"
            if not set -q target_repo[1]
                echo "Usage: ov delete <repo-name>"
                return 1
            end
            set target_path "$HOME/.ov/repo/$target_repo"
            if not test -d "$target_path"
                echo "Repository '$target_repo' not found"
                return 1
            end
            echo "Delete repository '$target_repo'? (y/N)"
            read -l confirm
            if test "$confirm" = "y" -o "$confirm" = "Y"
                rm -rf "$target_path"
                echo "Repository '$target_repo' deleted"
            else
                echo "Cancelled"
            end
            return 0
        case "help"
            echo "Usage: ov <command> [args...]"
            echo ""
            echo "Commands:"
            echo "  list                     List all overlay repositories"
            echo "  delete <repo-name>       Delete an overlay repository"
            echo "  <repo-name> <command>    Run git or gh command on repository"
            echo ""
            echo "Examples:"
            echo "  ov list"
            echo "  ov delete old-repo"
            echo "  ov claude status"
            echo "  ov claude add file.txt"
            echo "  ov claude repo view --web"
            echo ""
            echo "Setup: ov-setup <repo-name> <git-url>"
            return 0
        case ""
            echo "Usage: ov <command> [args...]"
            echo "Run 'ov help' for more options"
            return 1
    end
    
    # Validate repo name provided for git commands
    set -q repo_name[1]; or begin
        echo "Usage: ov <repo-name> <git-command> [args...]"
        echo "Run 'ov help' for more options"
        return 1
    end
    
    # Set up repository path
    set repo_path "$HOME/.ov/repo/$repo_name"
    
    # Check if repository exists
    test -d "$repo_path"; or begin
        echo "Repository '$repo_name' not found at $repo_path"
        echo "Use 'ov-setup $repo_name <git-url>' to initialize"
        return 1
    end
    
    # Set git environment variables for overlay configuration
    set -lx GIT_DIR "$repo_path"
    set -lx GIT_WORK_TREE "$HOME"
    
    # Extract the git command
    set cmd $argv[2]
    
    # Route commands appropriately - use git for core git operations
    switch $cmd
        case add am archive bisect branch bundle checkout cherry-pick clean clone commit \
             describe diff fetch format-patch gc grep init log maintenance merge mv notes \
             pull push range-diff rebase reset restore rm show stash status switch tag \
             worktree
            # Always use git for core git operations
            /usr/bin/git $argv[2..]
        case '*'
            # Try gh first for GitHub-specific commands, fallback to git
            if command -v gh >/dev/null 2>&1
                gh $argv[2..]; or /usr/bin/git $argv[2..]
            else
                /usr/bin/git $argv[2..]
            end
    end
end
status is-interactive; or ov $argv
