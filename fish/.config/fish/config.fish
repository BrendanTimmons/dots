source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    # smth smth
end

zoxide init fish | source

set -gx EDITOR nvim

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	command rm -f -- "$tmp"
end

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end


# Added by Qwen Code standalone installer
fish_add_path "/home/brendan/.local/bin"

# Cargo bin directory
fish_add_path "/home/brendan/.cargo/bin"

# local variables
source ~/.config/my-env.sh
