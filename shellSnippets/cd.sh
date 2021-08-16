alias ..='cd ../'


sa(){
        ssh-agent | grep -v 'echo' > ~/.ssh_agent_info
        source .ssh_agent_info
        ssh-add ~/.ssh/id_rsa
}
source ~/.ssh_agent_info
alias sar='source .ssh_agent_info'

fs() {
  local dir
  if [ $# -eq "0" ] ; then
	  dir=$(cat ~/.ssh/config  | grep '^host ' | cut -d' ' -f2 | fzf +m --header="Переход к серверу") && set_xterm_title "xterm SSH to $dir" && ssh "$dir" ; set_xterm_title "xterm"
  else
	  dir=$(cat ~/.ssh/config  | grep '^host ' | grep "$1" | cut -d' ' -f2 | fzf +m --header="Переход к серверу") && set_xterm_title "xterm SSH to $dir" && ssh "$dir"; set_xterm_title "xterm"
  fi
}


p() {
	local dir
	dir=$(/mnt/Beta/ | fzf +m) && cd $(/mnt/Beta/ -e "$dir")
	set_xterm_title "xterm WORKING in $dir"
	if [ -f .nvmrc ]; then
		use-nvm
		echo "Switching node: "
		cat .nvmrc
		nvm use;
	fi

	if [ -f .phpbrewrc ]; then
		use-phpbrew
		echo "Switching php: " `cat .phpbrewrc`
		phpbrew use `cat .phpbrewrc`
	fi

	if [ -f .ruby-version ]; then
		use-rvm
		rvm use $(cat .ruby-version)
		#echo "Switching php: " `cat .phpbrewrc`
		#phpbrew use `cat .phpbrewrc`
	fi
	if [ -d venv ]; then
		use-venv
	fi
}
