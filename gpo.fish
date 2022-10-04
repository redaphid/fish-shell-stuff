function gpo --description 'Pushes current branch to the specified origin. Useful for pushing to multiple repos' --argument repo_name save
    set -q repo_name[1]; or set repo_name $GPO_DEFAULT_REPO
    set -q repo_name[1]; or begin
        echo "Must specify a repo name, or set GPO_DEFAULT_REPO to something (likely origin)"
        echo "e.g. gpo redaphid"
        return
    end
    set -q save[1]; and set extra_options set extra_options ('--set-upstream $repo_name')
    git push $extra_potions $repo_name (git branch --show-current)
end
