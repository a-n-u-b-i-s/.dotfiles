set default_path /usr/bin /usr/sbin /bin /sbin
set homebrew /opt/homebrew/bin
set pnpm_path /Users/anubis/Library/pnpm
set rust_path /Users/anubis/.cargo/bin
set -gx PATH $homebrew $default_path $pnpm_path $rust_path

starship init fish | source
jump shell fish | source
set -g fish_greeting

# Carbonfox Color Palette
set -l foreground f2f4f8
set -l selection 2a2a2a
set -l comment 6e6f70
set -l red ee5396
set -l orange 3ddbd9
set -l yellow 08bdba
set -l green 25be6a
set -l purple be95ff
set -l cyan 33b1ff
set -l pink ff7eb6

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
neofetch 

function list_dir --on-variable PWD; ls -lAh; end;

function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

alias ga="git add ."
alias gc="git cz"
alias pip="pip3"
alias gi="git init"
alias gp="git push origin"
alias gpm="git push origin main"
alias gpd="git push origin develop"
alias grep="rg"
alias tf="touch"
alias mkd="mkdir -p"
alias z="git add . ; git cz"

set -g EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# pnpm
set -gx PNPM_HOME "/Users/anubis/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
