#!/usr/bin/env fish
function ov-setup --description 'Initialize new overlay git repository' --argument repo_name git_url
    # Validate repo name provided
    set -q repo_name[1]; or begin
        echo "Usage: ov-setup <repo-name> <git-url>"
        echo "Example: ov-setup claude https://github.com/sibipro/dot-claude.git"
        return 1
    end
    
    # Validate git URL provided
    set -q git_url[1]; or begin
        echo "Git URL required"
        echo "Usage: ov-setup <repo-name> <git-url>"
        return 1
    end
    
    set repo_path "$HOME/.ov/repo/$repo_name"
    
    # Check if repository already exists
    test -d "$repo_path"; and begin
        echo "Repository '$repo_name' already exists at $repo_path"
        return 1
    end
    
    # Create directory and clone
    echo "Cloning $git_url to $repo_path..."
    mkdir -p (dirname "$repo_path")
    git clone --bare "$git_url" "$repo_path"; or begin
        echo "Failed to clone repository"
        return 1
    end
    
    # Configure to hide untracked files
    echo "Configuring repository..."
    /usr/bin/git --git-dir="$repo_path" --work-tree="$HOME" config --local status.showUntrackedFiles no
    
    echo "Repository '$repo_name' initialized successfully!"
    echo "Use 'ov $repo_name status' to check status"
    echo "Use 'ov $repo_name checkout' to checkout files (backup any conflicts first)"
end
status is-interactive; or ov-setup $argv