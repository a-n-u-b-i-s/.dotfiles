# Hide Fish Welcome Message
set -g fish_greeting

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Melange Color Palette
# set -l foreground ECE1D7
# set -l selection ECE1D7
# set -l comment C1A78E
# set -l red BD8183
# set -l orange E49B5D
# set -l yellow EBC06D
# set -l green 78997A
# set -l purple B380B0
# set -l cyan 7B9695
# set -l pink CF9BC2

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.fish.inc' ]
    . '$HOME/google-cloud-sdk/path.fish.inc'
end

# Application Setup
starship init fish | source
zoxide init fish | source

# Default Editor
set -g EDITOR nvim

# LS on CD
function list_dir --on-variable PWD
    eza -lah
end

# Rerun Last Command with Sudo using `sudo !!`
function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# Expand `..` to `../..`
function expand-dot-to-parent-directory-path -d 'expand ... to ../.. etc'
    # Get commandline up to cursor
    set -l cmd (commandline --cut-at-cursor)

    # Match last line
    switch $cmd[-1]
        case '*..'
            commandline --insert '/.'
        case '*'
            commandline --insert '.'
    end
end

function expand_dot_key_binding
    fish_default_key_bindings
    bind . expand-dot-to-parent-directory-path
end

set -g fish_key_bindings expand_dot_key_binding

# Add Custom Functions
for f in ~/.config/fish/functions/*
    source $f
end

# Git Aliases
alias ga="git add ."
alias gc="git cz"
alias gpl="git pull"
alias gps="git push"
alias gi="git init"

# Directory Aliases
alias mkd="mkdir -p"
alias la="eza -lah"

# App Aliases
alias grep="rg"
alias diff="diff-so-fancy"
alias cat="BAT_THEME=tokyonight_night bat"
alias zed="/Applications/Zed.app/Contents/MacOS/cli"

alias ff="fd --hidden --type file --exclude .git/ --exclude node_modules/ | fzf-tmux -p | xargs nvim"
alias tf="touch"

if status is-interactive
    neofetch
end

# Path Env Variables
set default_path /usr/bin /usr/sbin /bin /sbin
set homebrew /opt/homebrew/bin /opt/homebrew/sbin
set rust_path $HOME/.cargo/bin
set asdf_path $HOME/.asdf/shims
set -gx PATH $fish_user_paths $homebrew $default_path $rust_path

# pnpm Paths
set -gx PNPM_HOME $HOME/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
source "/Users/$HOME/.opam/opam-init/init.fish" >/dev/null 2>/dev/null; or true

fish_vi_key_bindings
