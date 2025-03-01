if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_user_key_bindings
    fzf_configure_bindings --directory=\cf --git_log=\cl --git_status=\cs --processes=\cp
end

fish_add_path ~/.local/bin
# fish_user_key_bindings

export VISUAL=nvim
export EDITOR=nvim

# omf theme config
set -g theme_color_scheme dracula
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '
set -g theme_nerd_fonts yes

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream none

# default browser for fish shell
# set -gx BROWSER arc

# eza config
if command -v eza >/dev/null
    abbr -a l eza
    abbr -a ll 'eza -la'
    abbr -a lll 'eza -la'
else
    abbr -a l ls
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

# Tmux
# Attaches tmux to a session (example: ta portal)
alias ta='tmux attach -t'
# Creates a new session
alias tn='tmux new-session -s '
# Kill session
alias tk='tmux kill-session -t '
# Lists all ongoing sessions
alias tl='tmux list-sessions'
# Detach from session
alias td='tmux detach'
# Tmux Clear pane
alias tc='clear; tmux clear-history; clear'

# # tmuxinator
# if command -v tmuxinator >/dev/null
#     abbr -a tx tmuxinator
# end

# Setting Python Envs 
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /opt/homebrew/bin/conda
# eval /opt/homebrew/bin/conda "shell.fish" hook $argv | source
# end

if test -f ~/miniconda3/_conda
    fish_add_path ~/miniconda3/condabin/
    eval ~/miniconda3/condabin/conda "shell.fish" hook $argv | source
end

# setting pydev
# export PYENV_ROOT="$HOME/.pyenv"
# fish_add_path $PYENV_ROOT/shims
# fish_add_path $PYENV_ROOT/bin
# begin
# 	eval pyenv init --path
# 	eval pyenv init -
# 	eval pyenv virtualenv-init -
# 	eval direnv hook fish
# end &> /dev/null

# Setting golang & GOENV
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export GOROOT="/usr/local/go"
export PATH="$GOROOT/bin:$PATH"

# Rust env
fish_add_path $HOME/.cargo/bin
source "$HOME/.cargo/env.fish"

# aws-cli docker
# alias aws='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
# aws-cli with aws_completer
abbr -a aws_completer /snap/aws-cli/current/bin/aws_completer
if command -v /snap/aws-cli/current/bin/aws_completer >/dev/null
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); /snap/aws-cli/current/bin/aws_completer | sed \'s/ $//\'; end)'
end

# Minikube completion
if command -v minikube >/dev/null
    minikube completion fish | source
end

# kubectl autocompleter
if command -v kubectl >/dev/null
    kubectl completion fish | source
    alias kc="kubectl"
end

# zoxide
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# dotfiles for managing configuration
alias dotfiles='git --git-dir=/home/bj/.config/.dotfiles --work-tree=/home/bj'
alias dotfiles_lazygit='lazygit --git-dir=/home/bj/.config/.dotfiles --work-tree=/home/bj'
