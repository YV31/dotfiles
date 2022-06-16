#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Append "$1" to $PATH when not already in.
# This function was taken from /etc/profile
append_path() {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

append_path "$HOME/.local/bin"
append_path "$HOME/.local/share/gem/ruby/3.0.0/bin"

unset -f append_path

#
# XDG Base Directory
#

# User directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# System directories
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

#
# Program specific
#

# Clean up $HOME
export GFORTHHIST="$XDG_DATA_HOME/gforth-history"

