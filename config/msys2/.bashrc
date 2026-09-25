# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
  *) return ;;
esac

# Path to the oh-my-bash installation.
export OSH="$HOME/.oh-my-bash"

# Docker segment for powerbash10k
function __pb10k_prompt_docker {
  if [[ -f /.dockerenv ]] || grep -q docker /proc/1/cgroup 2>/dev/null; then
    local color box info

    color=$_omb_prompt_bold_blue
    info=" "
    box=""

    printf "%s|%s|%s|%s" \
      "$color" \
      "$info" \
      "$_omb_prompt_bold_black" \
      "$box"
  fi
}

# OS segment for powerbash10k
function __pb10k_prompt_os {
  local color box info

  color=$_omb_prompt_bold_white
  box=""

  case "$(uname -s)" in
    Darwin*) info="macOS" ;;
    MSYS*|MINGW*|CYGWIN*) info="Windows" ;;
    *)
      if [[ -r /etc/os-release ]]; then
        # shellcheck disable=SC1091
        . /etc/os-release
        info="${PRETTY_NAME:-$NAME}"
      else
        info="Linux"
      fi
      ;;
  esac

  case "$info" in
    *Ubuntu*) info=" " ;;
    *Arch*) info=" " ;;
    *Debian*) info=" " ;;
    *Fedora*) info=" " ;;
    *macOS*) info=" " ;;
    *Windows*) info=" " ;;
    *Rocky*|*Rocky\ Linux*) info=" " ;;
    *openSUSE*) info=" " ;;
    *) info=" " ;;
  esac

  printf "%s|%s|%s|%s" \
    "$color" \
    "$info" \
    "$_omb_prompt_bold_black" \
    "$box"
}

__PB10K_TOP_LEFT="os docker dir scm"

# Set name of the theme to load.
OSH_THEME="powerbash10k"
COMPLETION_WAITING_DOTS="true"
OMB_USE_SUDO=false
OMB_PROMPT_SHOW_PYTHON_VENV=true

completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

# Load bash-completion when installed through MSYS2.
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

source "$OSH/oh-my-bash.sh"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# User aliases
alias bashrc='source ~/.bashrc'
alias dev='cd "$HOME/Dev"'
alias lg='lazygit'
alias requirements='python -m pip install -r requirements.txt'
alias vb='vim ~/.bashrc'
alias venv='if [[ -f .venv/Scripts/activate ]]; then source .venv/Scripts/activate; else source .venv/bin/activate; fi'
alias vim='nvim'
alias vp='vim ~/.profile'

# Optional shell integrations
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --bash)
fi

if command -v nodenv >/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi

[[ ! -f "$HOME/.cargo/env" ]] || source "$HOME/.cargo/env"

export DO_NOT_TRACK=1
if command -v npm >/dev/null 2>&1; then
  npm_prefix=$(npm config get prefix 2>/dev/null)
  if [[ "$npm_prefix" == *:* ]] && command -v cygpath >/dev/null 2>&1; then
    npm_prefix=$(cygpath -u "$npm_prefix")
  fi
  [[ -z "$npm_prefix" ]] || export PATH="$npm_prefix:$PATH"
  unset npm_prefix
fi

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
