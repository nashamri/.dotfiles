#!/bin/bash

dir=~/.dotfiles
olddir=~/.dotfiles_old
files="aliases bashrc git-completion.bash git-prompt.sh gitconfig hgrc spacemacs tmux.conf vimrc"

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

echo "Changing to the $dir directory"
cd $dir
echo "...done"

for file in $files; do
    echo "Moving any existing dotfiles form ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo "Creating UltiSnips"
mkdir -p ~/.vim/UltiSnips
ln -s ~/.dotfiles/UltiSnips/* ~/.vim/UltiSnips
echo "Done"

echo "Creating spacemacs private layer"
mkdir -p ~/.emacs.d/private
ln -s ~/.dotfiles/private/* ~/.emacs.d/private
echo "Done"
