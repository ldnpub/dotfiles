###############################Save .dotfiles to github
# https://www.atlassian.com/git/tutorials/dotfiles
# git init --bare $HOME/.cfg
# alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# config config --local status.showUntrackedFiles no
# echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias config-push='dotfile-update-to-git'

#### Docker -> https://blog.ropnop.com/docker-for-pentesters/ && https://medium.com/@nima.saed/metasploit-framework-console-on-docker-with-workspace-fc39f0f2a078
alias kali='docker run -it -v "${HOME}/kali:/root/" kalilinux/kali-linux-docker /bin/bash'
alias msfvenomhere='docker run --rm -it -v "${HOME}/.msf4:/home/msf/.msf4" -v "${PWD}:/data" -p 5432:5432 metasploitframework/metasploit-framework ./msfvenom'
alias metasploit='msf-docker'  
alias webdavhere='docker run --rm -it -p 80:80 -v "${PWD}:/srv/data/share" rflathers/webdav'
alias nginxhere='docker run --rm -it -p 80:80 -p 443:443 -v "${PWD}:/srv/data" rflathers/nginxserve'
alias impacket="docker run --rm -it rflathers/impacket" 
alias dockershell="docker run --rm -i -t --entrypoint=/bin/bash"
alias dockershellsh="docker run --rm -i -t --entrypoint=/bin/sh"

function msf-docker() {
     if [ -z "$(docker network ls | grep -w msf)" ];
     then      
	     docker network create --subnet=172.18.0.0/16 msf  
     fi  
     if [ -z "$(docker ps -a | grep -w postgres)" ];
     then      
	     docker run --ip 172.18.0.2 --network msf --rm --name postgres -v "${HOME}/.msf4/database:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=msf -d postgres:latest  
     fi   
     docker run --rm -it -u 0 --network msf --name msf --ip 172.18.0.3 -v "${HOME}/.msf4:/home/msf/.msf4" -p 8443-8500:8443-8500 metasploitframework/metasploit-framework 
}

function dockershellhere() {
    dirname=${PWD##*/}
    docker run --rm -it --entrypoint=/bin/bash -v `pwd`:/${dirname} -w /${dirname} "$@"
}
function dockershellshhere() {
    dirname=${PWD##*/}
    docker run --rm -it --entrypoint=/bin/sh -v `pwd`:/${dirname} -w /${dirname} "$@"
}

function() dotfile-update-to-git{
	cd $HOME
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME status | grep modifié | awk '{print $2}' > /tmp/git.status
	while IFS= read -r line; do
    		/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add $line
	done < /tmp/git.status
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME commit -m "update"
	/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME push
}

##### BASH
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias src='source ${HOME}/.zshrc'
