function gpo --description 'Pushes current branch to the specified origin. Useful for pushing to multiple repos' --argument repo_name
        set -q repo_name[1]; or set repo_name $GPO_DEFAULT_REPO
        set -q repo_name[1]; or begin
            echo "Must specify a repo name, or set GPO_DEFAULT_REPO to something (likely origin)"
            echo "e.g. gpo redaphid"
        return
    end
    git push $repo_name (git branch --show-current)
end
