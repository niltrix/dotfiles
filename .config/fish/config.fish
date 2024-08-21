if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/.local/bin
# fish_user_key_bindings

export VISUAL=nvim
export EDITOR=nvim

# omf theme config
set -g theme_color_scheme dracula
# set -g theme_newline_cursor yes
# set -g theme_newline_prompt '$ '
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

# autojump
# if command -v autojump >/dev/null
#     source /opt/homebrew/share/autojump/autojump.fish
# end
#
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
# export GOENV_ROOT="$HOME/.goenv"
# export PATH="$GOENV_ROOT/bin:$PATH"
# eval "$(goenv init -)"
# export GOROOT="/usr/local/go"
# export PATH="$GOROOT/bin:$PATH"

# Rust env
# fish_add_path $HOME/.cargo/bin
# source "$HOME/.cargo/env.fish"

# Setting fzf
# fzf --fish | source

# aws-cli docker
# alias aws='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
# aws-cli with aws_completer
# if command -v aws_completer >/dev/null
#     complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
# end
# kubectl autocompleter
# kubectl completion fish | source

# dotfiles for managing configuration
alias dotfiles='git --git-dir=/home/bj/.config/.dotfiles --work-tree=/home/bj'
