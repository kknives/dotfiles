# Dotfiles
A backup of configs for commonly used programs.
Following [this guide](https://www.ackama.com/blog/posts/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained)

## Installing the configs
Assuming that the git bare repository is called dotfiles.git
```
echo "dotfiles.git" >> .gitignore
git clone --bare https://github.com/kknives/dotfiles.git $HOME/dotfiles.git
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles.git --work-tree=$HOME'" >> $HOME/.zsh/aliasrc
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```
