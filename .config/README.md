

## dotfiles

```
# prep for dotfiles
$ echo "alias dotfiles='git --git-dir=$HOME/.config/.dotfiles --work-tree=$HOME'" >> $HOME/.config/fish/config.fish
$ source $HOME/.config/fish/config.fish

# prep for uploading
$ git init --bare ~/config/.dotfiles
$ dotfiles config --local status.showUntrackedFiles no

# download dotfiles from remote
$ git clone --bare <remote repo url> $HOME/.config/.dotfiles
$ mkdir -p $HOME/.config/backup_dotfiles
$ dotfiles checkout
if [ $? = 0 ]; then
	echo "Checked out config.";
else
	echo "Backing up pre-existing dot files.";
	dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
$ dotfiles checkout
$ dotfiles config status.showUntrackedFiles no
```
