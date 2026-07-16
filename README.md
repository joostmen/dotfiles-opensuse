### move dotfiles to generilzed folder
```
mkdir -p ~/dotfiles
mv ~/.config/hypr ~/dotfiles-opensuse/hypr
mv ~/.config/kitty ~/dotfiles-opensuse/kitty
mv ~/.config/lf ~/dotfiles-opensuse/lf
mv ~/.config/fastfetch ~/dotfiles-opensuse/fastfetch
mv ~/.zshrc ~/dotfiles-opensuse/.zshrc
mv ~/.tmux.conf ~/dotfiles-opensuse/.tmux.conf
```

### to link dotfiles
```
ln -s ~/dotfiles-opensuse/hypr ~/.config/hypr
ln -s ~/dotfiles-opensuse/kitty ~/.config/kitty
ln -s ~/dotfiles-opensuse/lf ~/.config/lf
ln -s ~/dotfiles-opensuse/fastfetch ~/.config/fastfetch
ln -s ~/dotfiles-opensuse/.zshrc ~/.zshrc
ln -s ~/dotfiles-opensuse/.tmux.conf ~/.tmux.conf

```

### to update packages
```
zypper se -i | awk -F'|' '/^i/{print $2}' | sed 's/ //g' > ~/dotfiles/packages.txt
```

### to install packages

```
sudo zypper install $(cat packages.txt)
```
