function __check_nvmrc --on-variable PWD
    if test -f .nvmrc
        set -l node_version (cat .nvmrc)
        pnpm env use $node_version
    end
end
