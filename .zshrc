eval "$(pyenv init -)"
eval "$(rbenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
export RUBY_ROOT="$HOME/.rbenv"
export PYTHONDONTWRITEBYTECODE=1

export PATH="$PYENV_ROOT/shims:$PATH"
export PATH="$RUBY_ROOT/bin:$PATH"

export PATH="$PATH:$HOME/bin"

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
alias gs="git status"
alias ga="git add"

source $ZDOTDIR/.config/zsh/base.zsh
