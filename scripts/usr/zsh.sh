wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

cp -f /settings/.zshrc /home/$(id -un)/.zshrc

# lf
mkdir -p ~/.linuxbrew/bin
ln -s /workdir/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
eval $(~/.linuxbrew/bin/brew shellenv)
sed -i "1iexport PATH=\$PATH:~/.linuxbrew/bin" /home/$(id -un)/.zshrc
brew install lf

sed -i "s~USER_NAME~$(id -un)~" ~/.zshrc
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "1isource ~/.env_var" ~/.zshrc
sed -i "1iif test -t 1; then\nexec zsh\nfi" ~/.bashrc
source ~/.bashrc
