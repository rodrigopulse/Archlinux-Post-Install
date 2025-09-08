export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  line_sep      # Line brak
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "

alias startDocker="sudo systemctl start docker"
alias gp="git push"
alias gpc="sudo rm -rf .next && git push"
alias gcm="git commit -m"
alias ga="git add"
alias gs="git status"

function arduino() {
  if [[ "$1" == "--upload" ]]; then
    pio run --target upload
  fi
  if [[ "$1" == "--start" ]]; then
    platformio run
  fi
  if [[ "$1" == "--vscode" ]]; then
    platformio init --ide vscode
  fi
  if [[ "$1" == "--build" ]]; then
    pio run
  fi
  if [[ "$1" == "--monitor" ]]; then
    pio device monitor
  fi
}

alias arduino='arduino'

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:$HOME/.local/bin
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion