# ===============================================================
# 1. INSTANT PROMPT (Must stay at the top)
# ===============================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===============================================================
# 2. SHELL THEME & ENVIRONMENT
# ===============================================================
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export TERM="xterm-256color"
export XDG_CURRENT_DESKTOP=GNOME

export PATH="$HOME/.local/bin:$PATH"

# Homebrew Setup
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  export HOMEBREW_CURL_PATH="/home/linuxbrew/.linuxbrew/bin/curl"
  export HOMEBREW_GIT_PATH="/home/linuxbrew/.linuxbrew/bin/git"
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# ===============================================================
# 3. HISTORY CONFIGURATION
# ===============================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history       
setopt share_history        
setopt hist_ignore_dups     
setopt hist_ignore_space    

# ===============================================================
# ALIASES & TOOLS INITIALIZATION
# ===============================================================
# Tool Init
eval "$(zoxide init zsh)"
eval $(thefuck --alias)

# Navigation & Files
alias cd="z"
alias ls='eza --icons --group-directories-first'
alias cl='clear'
alias o='xdg-open . > /dev/null 2>&1'
alias bat=batcat

# Git Aliases
alias gaa='git add .'
alias gmt='git commit -m'
alias gp='git push'

alias lg='lazygit'

# ===============================================================
# 5. CUSTOM FUNCTIONS
# ===============================================================
# Custom Disk Health Check
# Monitors XrayDisk 1TB PRO and Samsung PM961
check_disks() {
    echo "--- INTERNAL: XrayDisk 1TB PRO ---"
    sudo smartctl -a /dev/nvme0n1 | grep -iE "Critical Warning|Percentage Used|Available Spare|Temperature"
    
    echo -e "\n--- EXTERNAL: Samsung PM961 (SSD NGL) ---"
    if [ -e /dev/sda ]; then
        sudo smartctl -a /dev/sda | grep -E "Percentage Used|Critical Warning"
    else
        echo "External drive not detected. Check cable/port."
    fi
}

# ===============================================================
# 6. FZF CONFIGURATION (Tokyo Night Style)
# ===============================================================
source /usr/share/doc/fzf/examples/completion.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source ~/.fzf-git/fzf-git.sh

# Tokyo Night Color Scheme
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color=bg+:#283457,bg:#1a1b26,spinner:#bb9af7,hl:#7ad5f3 --color=fg:#c0caf5,header:#7ad5f3,info:#7dcfff,pointer:#bb9af7 --color=marker:#9ece6a,fg+:#c0caf5,prompt:#bb9af7,hl+:#7ad5f3"

# FD Commands (Include hidden files, ignore .git)
export FZF_DEFAULT_COMMAND="fdfind --hidden --no-ignore --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --no-ignore --strip-cwd-prefix --exclude .git"

# FZF Previews
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# FZF Completion Functions
_fzf_compgen_path() {
  fd --hidden --no-ignore --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --no-ignore --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "batcat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}
# ===============================================================
# 7. PLUGINS (Must be at the very bottom)
# ===============================================================
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ngl/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ngl/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ngl/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ngl/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

