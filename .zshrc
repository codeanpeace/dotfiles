#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####

# asdf
# support both git and homebrew as installation methods
[[ -s "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"
[[ -s "$(brew --prefix asdf)/libexec/asdf.sh" ]] && source "$(brew --prefix asdf)/libexec/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize PATH

export PATH="/usr/local/bin:$PATH"

export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

export ANDROID_HOME="/Development/sdks/android"
export PATH="/Development/sdks/android/platform-tools:/Development/sdks/android/tools:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmuxinator
[ -f ~/.tmuxinator/tmuxinator.zsh ] && source ~/.tmuxinator/tmuxinator.zsh

##### Elixir & Phoenix
export PATH="$PATH:/path/to/elixir/bin"
export ERL_AFLAGS="-kernel shell_history enabled"
export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"

# Lua
export PATH=$PATH:/usr/local/lib/luarocks/bin/

# Yarn
export PATH="$PATH:`yarn global bin`"

export PATH="$PATH:$HOME/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Set architecture flags
export ARCHFLAGS="-arch $(uname -m)"
export EDITOR="vim"

# Aliases

alias sw="telnet towel.blinkenlights.nl"

alias ~="cd ~"
alias dev="cd ~/Development"
alias src="cd ~/Development/src"
alias px="cd ~/Development/praxis"
alias ck="cd ~/Development/Crowdkicked"
alias uf="cd ~/Development/src/unfolded"
alias mp="cd ~/Development/src/mempao"

alias avh="cd ~/Development/Avhana/avhana"
alias ath="cd ~/Development/Avhana/athene"

alias sas="switchaudiosource"
alias sast="~/Development/Scripts/switch_audio_source.sh"

#### Navigation and interaction
alias .='echo $PWD'
alias l="ls -laGH"
alias c="cd"
function cd () { builtin cd "$@"; ls; }
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'

# Commands
alias v="vim"
alias et="emacs -nw"
alias s="subl"
alias st="stree"
alias o="open"
alias f='open -a Finder ./'
alias m="mkdir"
alias t="touch"
alias h='history'
alias nh='nohup'
alias el='elixir'
alias r='ruby'
alias p='pry'
alias es="elasticsearch"
alias ng="ngrok"
alias redis="redis-server"
alias brewu='brew update && brew upgrade && brew cleanup && brew prune && brew doctor'

alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e
's/^/ /' -e 's/-/|/'"
alias ocomms="lsof -i | grep ESTABLISHED"
alias ql="qlmanage -p"

##### Safer destructive commands
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias kl="clear"

# Tmux
alias tm="tmux"
alias tmi="tmux info"
alias tmlc="tmux list-commands"
alias tmlk="tmux list-keys"
alias tmls="tmux list-sessions"
alias tma="tmux attach -t $1"
alias tmr="tmux rename-window"
alias tmk="tmux kill-session -t $1"

###### Git
alias g="git"
alias gi="git init"
alias gd="git diff"
alias gdw="git diff --word-diff"
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
alias gwp="git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1"
alias git_overview="git log --all --oneline --no-merges"
alias git_recap="git log --all --oneline --no-merges --author=harrisontanh@gmail.com"
alias git_today="git log --since=00:00:00 --all --no-merges --oneline --author=harrisontanh@gmail.com"
alias git_graph="git log --graph --all --decorate --stat --date=iso"

##### Phoenix
alias phxs="iex -S mix phx.server"
alias mts="iex -S mix test"
alias mr="mix run"
alias mt="mix test"
alias mdg="mix deps.get"
alias ma="mix archive"
alias mai="mix archive.install"
alias mh="mix hex"
alias ml="mix local"
alias mp="mix phx"
alias mpn="mix phx.new"
alias mpgc="mix phx.gen.context"
alias mpgs="mix phx.gen.schema"
alias mpgh"mix phx.gen.html"
alias mpr="mix phx.routes"
alias mec="mix ecto.create"
alias mem="mix ecto.migrate"
alias megm="mix ecto.gen.migration"

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
alias bni="bundle install && npm install"

berss() { bundle exec rake sunspot:solr:"$@"; }
bersr() { bundle exec rake sunspot:reindex; }

alias fs="foreman start"
alias fsd="foreman start -f Procfile.dev"

# Javascript
alias ni="npm install"
alias wp="webpack-dev-server --config config/webpack.config.js"

#### .zshrc
alias vzsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"

#### .tmux.conf
alias vtm="vim ~/.tmux.conf"
alias stm="tmux source-file ~/.tmux.conf"

#### .vimrc
alias vvim="vim ~/.vimrc"

# browsers
alias cm="chromium --user-data-dir $(mktemp -d)"
alias ff="firefox --new-instance --profile $(mktemp -d)"

# arm/intel
alias mzsh="arch -arm64 zsh"
alias izsh="arch -x86_64 zsh"
if [ "$(uname -p)" = "i386" ]; then
  echo "Running in i386 mode (Rosetta)"
  eval "$(/usr/local/homebrew/bin/brew shellenv)"
  alias brew='/usr/local/homebrew/bin/brew'
else
  echo "Running in ARM mode (M1)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  alias brew='/opt/homebrew/bin/brew'
fi

eval "$(zoxide init zsh)"

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
