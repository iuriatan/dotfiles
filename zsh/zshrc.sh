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

# Vars
	if [ -d $HOME/bin ]; then
		export PATH=$HOME/bin:$PATH
	fi

	# Python PIP installed tools
	if [ -d $HOME/.local/bin ]; then
		export PATH=$HOME/.local/bin:$PATH
	fi

	# android studio tools
	if [ -d $HOME/Android/Sdk ]; then
		export ANDROID_HOME=$HOME/Android/Sdk
		export PATH=$PATH:$ANDROID_HOME/emulator
		export PATH=$PATH:$ANDROID_HOME/tools
		export PATH=$PATH:$ANDROID_HOME/tools/bin
		export PATH=$PATH:$ANDROID_HOME/platform-tools
	fi

	# asdf (https://asdf-vm.com/)
	export ASDF_DATA_DIR=$(get_asdf_data_dir)

	if [ -d $ASDF_DATA_DIR ]; then
		. $ASDF_DATA_DIR/asdf.sh
		fpath=(${ASDF_DIR}/completions $fpath)
		autoload -Uz compinit && compinit
	fi

	# homebrew config for Rosetta software
	if [ -d /usr/local/Homebrew -a "$(uname -m)" = "x86_64" ]; then
		eval "$(/usr/local/Homebrew/bin/brew shellenv)"
	fi

	# zsh config
	HISTFILE=~/.zsh_history
	SAVEHIST=1000 
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history

	# macOS Rosetta
	if [ "$(uname -s)" = "Darwin" ]; then
		alias rosetta='arch -x86_64 zsh --login'
	fi

# Aliases
	alias v="vim -p"
	alias ls="exa"
	
	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
	export VISUAL=vim

	#source ~/dotfiles/zsh/plugins/fixls.zsh

#Functions
	for i in ~/dotfiles/function*.sh; do
		source $i
	done

	# Custom cd
	c() {
		cd $1;
		exa;
	}
	alias cd="c"

# For vim mappings: 
	stty -ixon

source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/keybindings.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

source ~/dotfiles/zsh/prompt.sh

