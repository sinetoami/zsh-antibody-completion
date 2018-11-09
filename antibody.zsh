#compdef _antibody antibody

_antibody() {
  typeset -A opt_args
  local line

  _arguments -C \
    "--help[Show context-sensitive help]" \
    "-h[Show context-sensitive help]" \
    "--parallelism=4[max amount of tasks to launch in parallel]" \
    "-p[max amount of tasks to launch in parallel]" \
    "1:command:->commands" \
    "2:purge:->list" \
    "*:: :->args" \
  && ret=0

   case $state in
    (commands)
      local _antibody_commands=(
        'bundle:[<bundles>...] - downloads a bundle and prints its source line'
        'update:updates all previously bundled bundles'
        'home:prints where antibody is cloning the bundles'
        'purge:purges a bundle from your computer'
        'list:lists all currently installed bundles'
        'init:initializes the shell so Antibody can work as expected'
      )
      _describe -t commands "Antibody Commands" _antibody_commands && ret=0
    ;;
    (list)
      case $line[1] in
        (purge)
          local -a _list; _list=($(antibody list | awk '{print $1}' | sed 's/https:.*\.com\///g'))
          _describe -t list "Bundles List" _list && ret=0
        ;;
      esac
    ;;
   esac

  return 1
}

compdef _antibody antibody
