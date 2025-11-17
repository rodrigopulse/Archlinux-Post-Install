
#!/bin/bash
set -e

# Pergunta nome e email para o git logo no início
read -p "Digite seu nome para o git: " git_name
read -p "Digite seu email para o git: " git_email

echo ">>> Atualizando sistema..."
sudo pacman -Syu --noconfirm

echo ">>> Instalando pacotes essenciais..."
sudo pacman -S --noconfirm base-devel git vim wget curl unzip python-pip zsh

echo ">>> Configurando o git..."

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global core.editor "vim"

echo ">>> Instalando yay (AUR helper)..."
if ! command -v yay &> /dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

echo ">>> Instalando o Chrome..."
yay -S --noconfirm google-chrome

echo ">>> Instalando o slack..."
yay -S --noconfirm slack-desktop

echo ">>> Instalando vsCode..."
yay -S --noconfirm visual-studio-code-bin

echo ">>> Instalando demais pacotes do AUR..."
yay -S --noconfirm postman-bin spotify

echo ">>> Instalando NVM..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh
  else
  echo "NVM já está instalado."
fi

echo ">>> Instalando NodeJS..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install --lts
nvm use --lts
npm install -g yarn

echo ">>> Instalando fonte jetbrains mono..."
sudo pacman -S --noconfirm ttf-jetbrains-mono

echo ">>> Instalando oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh já está instalado."
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting já está instalado."
fi

if [ ! -d "$HOME/.spaceship-prompt" ]; then
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git ~/.spaceship-prompt
  ln -s ~/.spaceship-prompt/spaceship.zsh ~/.zsh/themes/spaceship.zsh
else
  echo "Spaceship prompt já está instalado."
fi

echo ">>> Copiando arquivo .zshrc..."
mv ~/.zshrc ~/.zshrc.backup
cp ./zshrc ~/.zshrc

echo ">>> Alterando shell padrão para zsh..."
chsh -s $(which zsh)

echo ">>> Instalando platformio..."
pip install -U platformio

echo ">>> Instalando Alacritty..."
yay -S --noconfirm alacritty

echo ">>> Configurando Alacritty..."
mkdir -p ~/.config/alacritty
cp ./alacritty.toml ~/.config/alacritty/alacritty.toml

echo ">>> Instalando Tmux..."
sudo pacman -S tmux
cp ./.tmux.conf ~/

echo ">>> Instalando Docker"
sudo pacman -S --noconfirm docker docker-compose

echo ">>> Habilitando e iniciando Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo ">>> Instalando ambiente Android..."
sudo pacman -S jdk17-openjdk
sudo archlinux-java set java-17-openjdk
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
yay -S android-studio

echo ">>> Instalando dependências do emulador Android..."
sudo pacman -S --noconfirm qemu libvirt virt-manager dnsmasq bridge-utils openbsd-netcat ebtables iptables

echo ">>> Adicionando usuário aos grupos necessários..."
sudo usermod -aG libvirt $USER
sudo usermod -aG docker $USER
sudo usermod -aG uucp $USER   # acesso a portas seriais (Arduino/ESP)
sudo usermod -aG lock $USER   # algumas distros usam este grupo também

echo ">>> Instalação concluída! Por favor, reinicie o sistema."
