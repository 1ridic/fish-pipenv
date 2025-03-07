# set the user installation path

# complete --command pipenv --arguments "(env _PIPENV_COMPLETE=complete-fish COMMANDLINE=(commandline -cp) pipenv)" -f

function __pipenv_shell_activate --on-variable PWD
    if status --is-command-substitution
        return
    end
    if not test -e "$PWD/Pipfile"
        if not string match -q "$__pipenv_fish_initial_pwd"/'*' "$PWD/"
            set -U __pipenv_fish_final_pwd "$PWD"
            exit
        end
        return
    end

    if not test -n "$PIPENV_ACTIVE"
        if pipenv --venv >/dev/null 2>&1
        set -x __pipenv_fish_initial_pwd "$PWD"

        if [ "$pipenv_fish_fancy" = 'yes' ]
            set -- __pipenv_fish_arguments $__pipenv_fish_arguments --fancy
        end

        pipenv shell $__pipenv_fish_arguments

        set -e __pipenv_fish_initial_pwd
        if test -n "$__pipenv_fish_final_pwd"
            if command -q zoxide
                z "$__pipenv_fish_final_pwd"
            else
                cd "$__pipenv_fish_final_pwd"
            end
            set -e __pipenv_fish_final_pwd
        end
        end
    end
end
