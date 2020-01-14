current_dir="$( cd "$( dirname "$0" )" && pwd )"
message=$(tput bold)$(tput setaf 6)
error=`tput setaf 1`
success=`tput setaf 2`
info=`tput setaf 3`
reset=`tput sgr0`

check_dependencies () {
	while test $# -gt 0; do
    if [[ $(command -v $1) == "" ]]; then
      echo "${error}Required dependency ${1} is not installed${reset}"
      exit
    fi
    shift
	done
}

run_all_installers() {
  find $current_dir -name install.sh -mindepth 2 | while read installer ; do sh "${installer}" ; done
}

echo "› ${message}Checking dependencies${reset}"
check_dependencies curl git zsh
echo "${success}All dependencies installed${reset}"

echo "› ${message}Hides 'Last login' message${reset}"
if [[ ! -e $HOME/.hushlogin ]]; then
  echo "Creating ${HOME}/.hushlogin"
  touch $HOME/.hushlogin
else
  echo "${info}${HOME}/.hushlogin already exists${reset}"
fi

run_all_installers