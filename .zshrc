export PATH=$HOME/bin:/usr/local/bin:$PATH:~/go/bin:$HOME/.local/bin:/opt/Signal:/usr/local/rider/bin:$HOME/.krew/bin:$HOME/.cargo/bin
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="spaceship"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump"

# oh-my-zsh- plugin settings
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true

#plugins=(aws ssh-agent common-aliases gpg-agent history zsh-completions vi-mode kubectl)
plugins=(aws ssh-agent common-aliases gpg-agent history zsh-completions zsh-autosuggestions zsh-syntax-highlighting vi-mode kubectl docker extract pass systemd tmux web-search)
autoload -U compinit && compinit

source <(kubectl completion zsh)
source <(helm completion zsh)


source "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme"
export SPACESHIP_TIME_SHOW=false
export SPACESHIP_KUBECONTEXT_SHOW=true
export SPACESHIP_EXEC_TIME_SHOW=false
export SPACESHIP_AWS_SHOW=true
export SPACESHIP_EXIT_CODE_SHOW=true
export SPACESHIP_PROMPT_PREFIXES_SHOW=false
export SPACESHIP_BATTERY_SHOW=false
export SPACESHIP_GIT_STATUS_SHOW=false
export SPACESHIP_GIT_BRANCH_SHOW=true
export SPACESHIP_RUBY_SHOW=false
export SPACESHIP_ELIXIR_SHOW=false
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  aws           # Amazon Web Services section
  venv          # virtualenv section
  kubecontext
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

export RPS1="%{$reset_color%}"
source $ZSH/oh-my-zsh.sh

# User configuration
alias k='kubectl'
alias ks='kubectl -n kube-system'
alias km='kubectl -n monitoring'
alias ks='kubectl -n kube-system'
alias kmt='kubectl -n mt-system'
alias vi='vim'
alias gd='git diff --color=always | less -r'
alias tidy='tidy -q -xml -indent'
alias gf='git fetch'
alias gs='git status'
alias au='sudo apt update'
unalias rm
unalias cp
unalias mv

export DOTFILES_REPO_PATH=~/dotfiles
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PYTHONWARNINGS="ignore:Unverified HTTPS request"

export pup=~/dev/puppet-cloud
export deki=~/dev/Deki
export cfn=$deki/infrastructure/amazon-aws/cloudformation/pymtcfn
export k8s=$cfn/k8s
alias pup="cd $pup"
alias deki="cd $deki"
alias cfn="cd $cfn; source .venv/bin/activate"
alias k8s="export AWS_DEFAULT_PROFILE=devcloud; cd $cfn; source .venv/bin/activate; cd k8s"
alias pymtutil="cd ~/dev/pymtutil &&  source .venv/bin/activate"
alias awsl="cd ~/dev/awslogs && source .venv/bin/activate"
export GOPATH=~/go

# don't correct arguments
setopt nocorrectall
setopt correct

source ~/.zshrc-private

# functions
mtssh()  {
    ssh -i ~/.ssh/mt-cloud -l ec2-user ${@}
}

export AWS_DEFAULT_PROFILE=devcloud
export AWS_PROFILE=devcloud
export CLOUD_NAME=alpha
export KUBECONFIG=~/.kube/config-${CLOUD_NAME}

awsprod()  {
    export AWS_DEFAULT_PROFILE=production
    export AWS_PROFILE=production
    export CLOUD_NAME=production
    export KUBECONFIG=~/.kube/config-${CLOUD_NAME}
}
awsstaging()  {
    export AWS_DEFAULT_PROFILE=staging
    export AWS_PROFILE=staging
    export CLOUD_NAME=staging
    export KUBECONFIG=~/.kube/config-${CLOUD_NAME}
}
awsdev()  {
    export AWS_DEFAULT_PROFILE=devcloud
    export AWS_PROFILE=devcloud
    export CLOUD_NAME=alpha
    export KUBECONFIG=~/.kube/config-${CLOUD_NAME}
}

awsshell() {
    aws ssm start-session --target $@
}

vpnon()  {
    sudo openvpn --config $HOME/mt.ovpn
}

vpnoff() {
    sudo killall -9 openvpn
}

extip() {
    curl -s ifconfig.co
}

alias ll='exa -alh --sort modified'
eval "$(lua5.3 $HOME/dev/z.lua/z.lua --init zsh)"
#
#export LAMBDASHARP=~/dev/LambdaSharpTool
#source $LAMBDASHARP/Scripts/set-lash-version.sh
#alias lash="dotnet run -p $LAMBDASHARP/src/LambdaSharp.Tool/LambdaSharp.Tool.csproj --"
#alias lash="dotnet lash"
export LAMBDASHARP_PROFILE=Default
export LAMBDASHARP_TIER=alpha

# export PATH="/home/petee/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
