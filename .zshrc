# vim: set ft=sh sw=4 et :

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH:~/go/bin:$HOME/.local/bin:/opt/Signal:/usr/local/rider/bin:$HOME/.krew/bin:/usr/local/pycharm-community-2020.1.2/bin/:/usr/local/idea-IU-211.7628.21/bin:$HOME/.dotnet/tools
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
HISTIGNORE='\&:fg:bg:ls:pwd:cd ..:cd ~-:cd -:cd:jobs:set -x:ls -l:ls -l'
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump"

# oh-my-zsh- plugin settings
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true

plugins=(aws ssh-agent common-aliases gpg-agent zsh-completions fzf zsh-syntax-highlighting vi-mode kubectl docker extract pass systemd tmux)

export RPS1="%{$reset_color%}"
source $ZSH/oh-my-zsh.sh

# completion
source ~/.zshrc-completion

# sqlite history
source $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/histdb-interactive.zsh
bindkey '^r' _histdb-isearch
bindkey -M histdb-isearch '^[;' _histdb-isearch-cd
autoload -Uz add-zsh-hook
add-zsh-hook precmd histdb-update-outcome

_zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where places.dir LIKE '$(sql_escape $PWD)%'
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv order by count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}
ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here

autoload -U compinit && compinit

# User configuration
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/.ripgreprc
export AWS_CLI_AUTO_PROMPT=on
export FZF_DEFAULT_COMMAND='rg --hidden  --ignore "\.venv" --ignore "\.pdb"'
export FZF_CTRL_R_OPTS="--preview 'echo {} |sed -e \"s/^ *\([0-9]*\) *//\" -e \"s/.\{$COLUMNS\}/&\n/g\"' --preview-window down:3"
export DOTFILES_REPO_PATH=~/dotfiles
export EDITOR='nvim'
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PYTHONWARNINGS="ignore:Unverified HTTPS request"
export pup=~/dev/puppet-cloud
export deki=~/dev/Deki
export cfn=$deki/infrastructure/amazon-aws/cloudformation/pymtcfn
export k8s=$cfn/k8s
export GOPATH=~/go
export BAT_THEME="TwoDark"

# don't correct arguments
setopt nocorrectall
setopt correct

# load aliases
source ~/.zshrc-aliases

# private stuff (credentials)
source ~/.zshrc-private

# functions
source ~/.zshrc-functions

# zoxide
eval "$(zoxide init zsh)"

if [ ! -z "$TMUX" ]; then
    TMUX_SESSION=$(tmux display-message -p '#S')
    if [[ "$TMUX_SESSION" = "staging" ]]; then
        awsstaging
    elif [[ "$TMUX_SESSION" = "prod" ]]; then
        awsprod
    elif [[ "$TMUX_SESSION" = "ripper" ]]; then
        awswheat
    else
       awsdev
    fi
fi

# 20230902 - not sure what this is for
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zshrc-nvm
source ~/.zshrc-sgpt
