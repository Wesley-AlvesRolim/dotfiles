### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Zinit plugins
zinit ice blockf
zinit ice wait="2" lucid atload="_zsh_autosuggest_start"
zinit light zsh-users/zsh-completions

autoload compinit
compinit

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zthxxx/jovial
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/completion.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/lib/key-bindings.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/archlinux/archlinux.plugin.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/docker-compose/docker-compose.plugin.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/docker/docker.plugin.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/eza/eza.plugin.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/foot/foot.plugin.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/git/git.plugin.zsh'
zinit snippet 'https://github.com/ohmyzsh/ohmyzsh/raw/master/plugins/mise/mise.plugin.zsh'
zinit ice as"completion"
zinit snippet 'https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker'
zinit light marlonrichert/zsh-hist


# zsh configuration
HISTFILE="$HOME/.zsh_history"
SAVEHIST=10000
HISTSIZE=12000

ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)

# zsh remove unknown commands
autoload -Uz add-zsh-hook
command-not-found () {
  # -f: force
  # -s: silent
  # -1: most recent history item
  (( ? == 127 )) && 
      hist -fs delete -1
}
add-zsh-hook precmd command-not-found

# Alias
alias ls="eza -1lxh  -F --classify=always --color=always --icons=always --no-quotes --hyperlink --group-directories-first --no-user --git -@"
alias la="eza -1oxlhA -F --classify=always --color=always --icons=always --no-quotes --hyperlink --group-directories-first --no-user"
alias vim="nvim"
alias vi="nvim"
alias nv="nvim"
alias lg="lazygit"
alias cat="bat"
alias less="more"
alias trash="gtrash"

# COREPACK
alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"
alias pnpm="corepack pnpm"

# pnpm
export PNPM_HOME="/home/wesley/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# ATAC
export ATAC_KEY_BINDINGS="~/.config/atac/vim_key_bindings.toml"
export ATAC_THEME="~/.config/atac/insomnia_theme.toml"

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
} 
export EDITOR="nvim"
export VISUAL="nvim"

# Dev Manager
eval "$(mise activate zsh)"
eval "$(/usr/bin/mise activate zsh)"

# Setopt
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion

# UV python
eval "$(uv generate-shell-completion zsh)"
