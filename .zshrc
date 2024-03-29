
export PYENV_ROOT="$HOME/.pyenv"
export RUBY_ROOT="$HOME/.rbenv"
export PYTHONDONTWRITEBYTECODE=1

export PATH="$PYENV_ROOT/shims:$PATH"
export PATH="$RUBY_ROOT/bin:$PATH"

eval "$(pyenv init -)"
eval "$(rbenv init -)"
eval "$(anyenv init -)"

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/local/bin"

export XDG_CONFIG_HOME=$HOME/dotfiles/.config
export XDG_CACHE_HOME=$HOME/.cache

export MANPAGER="col -b -x|nvim -R -c 'set ft=man nolist nomod noma' -"

PROMPT="%~ $ "
PROMPT_EOL_MARK=""

#tmux setting
ln -fs $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

# nvim
alias n="nvim"
alias x="xonsh"

# shell
alias sz="source $ZDOTDIR/.zshrc"
alias nz="nvim $ZDOTDIR/.zshrc"

# git
export PATH="$PATH:/usr/local/share/git-core/contrib/diff-highlight"
alias gs="git status"
alias ga="git add"

source $ZDOTDIR/.config/zsh/base.zsh
source $ZDOTDIR/.config/zsh/fzf.zsh
