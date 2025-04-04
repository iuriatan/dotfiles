
# Helper Functions
get_asdf_data_dir() 
{
	ASDF_TREE_COUNT="$(ls -a ~ | grep .asdf | wc -l | sed 's/ *//g')"
	if [ $ASDF_TREE_COUNT -eq 1 ]; then
		echo $HOME/$(ls -a ~| grep .asdf | sed 's/ *//g')
		exit 0
	fi

	SO="$(uname -s)"
	ARCH="$(uname -m)"

	if [ $ARCH = "arm64" -a $SO = "Darwin" ]; then
		echo "$HOME/.asdf"
	elif [ $ARCH = "x86_64" -a $SO = "Linux" ]; then
		echo "$HOME/.asdf"
	else
		echo "$HOME/.asdf-$ARCH"
	fi
}

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
export ASDF_DATA_DIR=$(get_asdf_data_dir)

if [ -d $ASDF_DATA_DIR ]; then
	. $ASDF_DATA_DIR/asdf.sh
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
