# Arch Linux Post Install Script

Script de pós-instalação para Arch Linux com foco em desenvolvimento **fullstack, mobile, IoT, entre outros**.

## 🚀 O que instala

- **Pacotes essenciais**: `base-devel`, `git`, `vim`, `wget`, `curl`, `docker`, `python3 + pip`, `zsh`
- **AUR helper**: [yay](https://github.com/Jguer/yay)
- **Aplicativos**: Google Chrome, VSCode, Postman, Slack, Android Studio, Spotify
- **Node.js** via NVM + Yarn + Expo CLI
- **Ambiente Android/React Native**: JDK 17, Gradle, Android Tools, Emulador Android (qemu/libvirt)
- **PlatformIO CLI** (Arduino/ESP32/IoT)
- **Shell**: Zsh + Oh My Zsh + Alacritty
- **Docker sem sudo** (usuário adicionado ao grupo `docker`)
- **Permissões para IoT** (usuário adicionado aos grupos `uucp` e `lock`)
- **Permissões para emuladores Android** (usuário adicionado ao grupo `libvirt`)

## 📦 Uso

Clone o repositório:

```bash
git clone https://github.com/rodrigopulse/archlinux-post-install.git
```

```bash
cd arch-post-install
```

```bash
chmod +x setup.sh

```

```bash
./setup.sh

```
