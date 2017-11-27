# Functions for colorized console output.

function header {
  echo ""
  echo "$(tput setaf 6)$1$(tput sgr0)"
  echo ""
}
function box_out() {
  # First Argument is the title of the box
	title=$1
	shift
  local s=("$@") b w
  for l in "${s[@]}"; do
    ((w<${#l})) && { b="$l"; w="${#l}"; }
  done
  tput setaf 3
  h=${b:${#title}}
  echo "┌─$title${h//?/─}─┐
│ ${b//?/ } │"
  for l in "${s[@]}"; do
    printf '│ %s%*s%s │\n' "$(tput setaf 4)" "-$w" "$l" "$(tput setaf 3)"
  done
  echo "│ ${b//?/ } │
└─${b//?/─}─┘"
  tput sgr 0
}
