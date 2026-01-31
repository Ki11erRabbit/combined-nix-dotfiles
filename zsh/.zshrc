typeset -U path cdpath fpath manpath
for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/xw5xd0zbz7m9zqq7s0r2rf821a72ar97-zsh-5.9/share/zsh/$ZSH_VERSION/help"

PROMPT="❬%F{13}%n%f❭ %f%F{13}図書館に%f %F{12}%d
%f "
autoload -U compinit && compinit
eval "$(zoxide init zsh )"

# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="1500"
SAVEHIST="1000"

HISTFILE="/home/ki11errabbit/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK

# Enabled history options
enabled_opts=(
  HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY autocd
)
for opt in "${enabled_opts[@]}"; do
  setopt "$opt"
done
unset opt enabled_opts

# Disabled history options
disabled_opts=(
  APPEND_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS
  HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS
)
for opt in "${disabled_opts[@]}"; do
  unsetopt "$opt"
done
unset opt disabled_opts

export PATH="$PATH:/home/ki11errabbit/.cabal/bin:/home/ki11errabbit/.local/bin:$PATH:/home/ki11errabbit/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/home/ki11errabbit/.cargo/bin"

if [[ -o interactive ]]; then
    exec nu
fi

if [[ $TERM != "dumb" ]]; then
  eval "$(starship init zsh)"
fi

source <(carapace _carapace zsh)

alias -- bat='bat --style plain'
alias -- batf='bat --style full'
alias -- cd=z
alias -- cp='cp -iv'
alias -- emacs='emacsclient -c -a "emacs"'
alias -- grep='grep --color=auto'
alias -- home=cd
alias -- ls='exa --icons'
alias -- mpv=mpv
alias -- mv='mv -iv'
alias -- rm='trash -v'
alias -- root='cd /'
alias -- tree='exa --tree --icons'
ZSH_HIGHLIGHT_HIGHLIGHTERS+=()


