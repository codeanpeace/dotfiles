
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
export PATH="/usr/local/bin:$PATH"

export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

export ANDROID_HOME="/Development/sdks/android"
export PATH="/Development/sdks/android/platform-tools:/Development/sdks/android/tools:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add RVM to PATH for scripting
export PATH="$HOME/.rvm/bin:$PATH"

export PATH="$PATH:$HOME/bin"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# Set architecture flags
export ARCHFLAGS="-arch x86_64"

export EDITOR=r"vim"

# source ~/.bin/tmuxinator.bash

alias sw="telnet towel.blinkenlights.nl"
alias tm="tmux"
alias ~="cd ~"
alias dev="cd ~/Development"
alias src="cd ~/Development/src"
alias ck="cd ~/Development/Crowdkicked"

alias avh="cd ~/Development/Avhana/avhana"
alias ath="cd ~/Development/Avhana/athene"

#### Navigation and interaction
alias .='echo $PWD'
alias l="ls -laGH"
alias c="cd"
cd() { builtin cd "$@"; ls; }
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias v="vim"
alias s="subl"
alias st="stree"
alias o="open"
alias f='open -a Finder ./'
alias m="mkdir"
alias t="touch"
alias h='history'
alias nh='nohup'
alias r='ruby'
alias p='pry'
alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
alias ocomms="lsof -i | grep ESTABLISHED"
alias ql="qlmanage -p"
##### Safer destructive commands
# alias rm="rm -i"
alias rm="trash"
alias mv="mv -i"
alias cp="cp -i"

##### Git
alias g="git"
alias gi="git init"
alias gd="git diff"
alias gf="git fetch"
alias ga="git add"
alias ga.="git add ."
alias gaa="git add -A"
alias gac="git add -A && git commit -m"
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit --amend --no-edit"
alias gph="git push"
alias gphu="git push -u"
alias gpl="git pull"
alias gplr="git pull --rebase --prune"
alias go="git checkout"
alias gob="git checkout -b"
alias gm="git merge"
alias gs="git status"
alias gl="git log"
alias glt="git log --graph --oneline --decorate --all"
alias gb="git branch"
alias gba="git branch --all"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gr="git rebase"
alias gri="git rebase -i"
alias grm="git rebase master"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias grs="git rebase --skip"
alias gd="git diff"
alias gcl="git clone"
alias grm="git remote"
alias gce="git config --global -e"
alias gsv="git add -A && git commit -m 'SAVEPOINT'"
alias gu="git reset HEAD~1 --mixed"
alias gwp="git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard"
# grgp(){ git remote add origin git@github.com:com:codeanpeace/"$@"; git push -u origin master; }
# nuke commit
# git reset --hard HEAD~1
# undo commit, but keep changes
# git reset HEAD~1
# undo commit, keep changes and index
# git reset --soft HEAD~1
# undo nuke
# git reflog
# git checkout -b someNewBranchName shaYouDestroyed
# git checkout -b mynewfeature
# ... edit files, add and commit ...
# git push -u origin mynewfeature

##### Rails
alias rl="rails"
alias rn="rails new"
rndpst(){ rails new "$@" -d postgresql -T; }
alias rg="rails generate"
alias rgt="rails generate task"
alias rgmi="rails generate migration"
alias rdmi="rails destroy migration"
alias rgm="rails generate model"
alias rgc="rails generate controller"
alias rgs="rails generate scaffold"
rgsc(){ rails generate scaffold_controller "$@" --skip-test-framework; }
alias rs="rails server"
alias rc="rails console"
alias rct="rails console test"
alias rdb="rails db"
##### Rake
alias rk="rake"
alias rr="rake routes"
alias rdbrs="rake db:reset"
alias rdbrst="rake db:reset RAILS_ENV=test"
alias rdbrb="rake db:rollback"
alias rdbrbt="rake db:rollback RAILS_ENV=test"
alias rdbd="rake db:drop"
alias rdbdt="rake db:drop RAILS_ENV=test"
alias rdbc="rake db:create"
alias rdbct="rake db:create RAILS_ENV=test"
alias rdbm="rake db:migrate"
alias rdbmt="rake db:migrate RAILS_ENV=test"
alias rdbs="rake db:seed"
alias rdbst="rake db:seed RAILS_ENV=test"
alias rt="rake -T"
##### Rspec
alias rsp="rspec"
##### Bundle
alias b="bundle"
alias bi="bundle install"
alias be="bundle exec"
alias ber="bundle exec rake"
alias bu="bundle update"

berss() { bundle exec rake sunspot:solr:"$@"; }
bersr() { bundle exec rake sunspot:reindex; }

alias fs="foreman start"

alias es="elasticsearch"

alias ng="ngrok"

alias redis="redis-server"

alias lo="/System/Library/CoreServices/'Menu Extras'/User.menu/Contents/Resources/CGSession -suspend"

##### Bash profile
alias sbp="subl ~/.bash_profile"
alias scbp="source ~/.bash_profile"

##### Searching
alias qf="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

##### Networking
alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

alias wga="wget -m -p -E -k -K -np"

# File.open("[File Path]", "w") { |f| f.write([target variable]) }

# Touch a file and open it in Sublime
ts(){
  touch $1
  subl $1
}

# mans: Search manpage given in agument '1' for term given in argument '2' (case insensitive)
# displays paginated result with colored search terms and two lines surrounding each hit. (Example: mans mplayer codec)
# --------------------------------------------------------------------
mans () {
    man $1 | grep -iC2 --color = always $2 | less
}

# showa: to remind yourself of an alias (given some part of it)
# ------------------------------------------------------------
showa () { /usr/bin/grep --color = always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#
# Go up a specified number of directories
#
up(){
    if [ -z $1 ]
    then
      cd ..
      return
    fi
    local levels = $1
    local result = "."
    while [ $levels -gt 0 ]
    do
        result = $result/..
        ((levels--))
    done
    cd $result
}

#
# Make a directory and change to it
#
mc(){
  if [ $# -ne 1 ]; then
         echo "Usage: mkcd <dir>"
         return 1
  else
         mkdir -p $1 && cd $1
  fi
}

#
# Create a file and open in vim
#
tv(){
  if [ $# -ne 1 ]; then
         echo "Usage: touchvim <filename>"
         return 1
  else
         touch $1 && vim $1
  fi
}

#
# moves file to ~/.Trash
# (use instead of rm)
#
trash(){
   if [ $# -eq 0 ]
   then
       echo Usage: trash FILE...
       return 1
   fi
   local DATE = $(date +%Y%m%d)
   [ -d "${HOME}/.Trash/${DATE}" ] || mkdir -p ${HOME}/.Trash/${DATE}
   for FILE in "$@"
   do
     mv "${FILE}" "${HOME}/.Trash/${DATE}"
     echo "${FILE} trashed!"
   done
}

#
# Prints out a long line. Useful for setting a visual flag in your terminal.
#
flag(){
    echo -e  "[==============="$@"==========\
              ($(date +"%A %e %B %Y %H:%M"))\
              =========="$@"===============]"
}

# Custom Prompt
txtblk='\[\e[0;30m\]' # Black
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
txtrst='\[\e[0m\]' # Text Reset

HISTFILESIZE=9000
export CLICOLOR=1
export LSCOLORS=fxexcxdxbxegedabagacad

function branch
{
    git status 2> /dev/null | ruby ~/Development/Scripts/branch.rb
}

# Bash Autocompletion
source `brew --prefix git`/etc/bash_completion.d/git-completion.bash
__git_complete g _git_main
__git_complete go _git_checkout
__git_complete gb _git_branch
__git_complete gr _git_rebase

echo "----------------------------------------------------------------"
echo "As Always, A Pleasure"
echo "You're running $(ruby -v)"
echo "You're riding $(rails -v)"
echo "Forgive but never forget with $(git --version)"
echo "----------------------------------------------------------------"

# Git Prompt
# source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
# PS1="\h:\W \u\$(__git_ps1 \" (%s) \")\$"

export PS1="$txtblu\w$txtgrn\[ \$(branch) \]$txtwht ∴$txtrst "

# added by Anaconda3 2.5.0 installer
export PATH="/Users/harrison/anaconda/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
