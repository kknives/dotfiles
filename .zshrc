# Dependancies You Need for this Config
# zsh-syntax-highlighting - syntax highlighting for ZSH in standard repos
# autojump - jump to directories with j or jc for child or jo to open in file manager
# zsh-autosuggestions - Suggestions based on your history

# Initial Setup
# mkdir -p "$HOME/.zsh"
# git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
# Setup Alias in $HOME/.zsh/aliasrc

# Enable colors and change prompt:
EDITOR="nvim"

# Pure Prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:prompt:continuation color green
PURE_PROMPT_SYMBOL=•
prompt pure

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.


# Load aliases and shortcuts if existent.
[ -f "$HOME/.zsh/aliasrc" ] && source "$HOME/.zsh/aliasrc"

# Load ; should be last.
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh
# source /usr/share/autojump/autojump.zsh 2>/dev/null
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source $HOME/.zsh/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# zsh-syntax-highlighting color changes
#ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
#ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

#bindkey -v # Vim keybindings and modal editing
bindkey '^X' autosuggest-accept

# Add to path
path+=('/home/sga/bin')
path+=('/home/sga/builds/node-v12.18.2-linux-x64/bin')
path+=('/usr/lib/cuda/bin')
path+=('/home/sga/.rbenv/bin')
path+=('/home/sga/.rbenv/plugins/ruby-build/bin')

eval "$(rbenv init -)"

PATH="/home/sga/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/sga/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/sga/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/sga/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/sga/perl5"; export PERL_MM_OPT;
