##### STARTUP
RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
RPS2=$RPS1

##### BINDINGS
bindkey "^R" history-incremental-search-backward
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

##### HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

##### PROMPT
autoload -Uz vcs_info
precmd() { vcs_info }
#zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{cyan}%~%f%F{green}${vcs_info_msg_0_}%f$ '
preexec () { print -Pn "%b%f" } 
RPROMPT="%(?..%F{red}%?🚫%f)"
printf "\033]0;`date "+%a %d %b %Y %I:%M %p"`\007"

export TERM="xterm-256color" CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
alias ls='ls -Gp'

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

#VARS
#for Apple Silicon
#export DOTNET_ROOT=/opt/homebrew/Cellar/dotnet/7.0.100/libexec
export DOTNET_ROOT="/usr/local/opt/dotnet/libexec"

alias ibrew='arch -x86_64 /usr/local/bin/brew'

export PATH="/opt/homebrew/opt/openjdk/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

complete -o nospace -C /opt/homebrew/bin/nomad nomad

#vim mode, a bit buggy?
#source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
#source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(direnv hook $SHELL)"

#shows some random warnings
#source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Added by Windsurf
#export PATH="/Users/ps/.codeium/windsurf/bin:$PATH"
