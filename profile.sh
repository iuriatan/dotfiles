# home binaries
if [ -d $HOME/bin ]; then
	export PATH=$HOME/bin:$PATH
fi

# homebrew config (feat. support for rosetta software)
if [ -d /usr/local/Homebrew -a "$(uname -m)" = "x86_64" ]; then
	eval "$(/usr/local/Homebrew/bin/brew shellenv)"
elif [ -d /opt/homebrew -a "$(uname -m)" = "arm64" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# asdf (https://asdf-vm.com/)
if [ -d "$HOME/.asdf" ]; then
	export ASDF_DATA_DIR="$HOME/.asdf"
	export PATH="$ASDF_DATA_DIR/shims:$PATH"
fi

# rustup
if [ -d "$HOME/.cargo/" ]; then
	. "$HOME/.cargo/env"
fi

# solana-cli
SOLANA_CLI_DIR=$HOME/.local/share/solana/install/active_release/bin

if [ -d $SOLANA_CLI_DIR ]; then
	export PATH=$PATH:$SOLANA_CLI_DIR
fi
