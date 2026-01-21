function __check_nvm --on-variable PWD --description 'Auto use .nvmrc version'
  status --is-command-substitution; and return

  if test -f .nvmrc
    set -l nvmrc_version (cat .nvmrc | string trim)

    # Check if the version is already active
    if command -v node >/dev/null
      set -l current_version (node --version | string replace 'v' '')
      if test "$current_version" != "$nvmrc_version"
        echo "Switching to Node $nvmrc_version from .nvmrc"
        nvm use $nvmrc_version
      end
    else
      echo "Using Node $nvmrc_version from .nvmrc"
      nvm use $nvmrc_version
    end
  end
end
