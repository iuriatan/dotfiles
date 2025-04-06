# Vars
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
	elif [ -d $HOME/Library/Android/sdk ]; then
		export ANDROID_HOME=$HOME/Library/Android/sdk
		export PATH=$PATH:$ANDROID_HOME/emulator
		export PATH=$PATH:$ANDROID_HOME/tools
		export PATH=$PATH:$ANDROID_HOME/tools/bin
		export PATH=$PATH:$ANDROID_HOME/platform-tools
	fi

	# mint binaries
	if [ -d $HOME/.mint/bin ]; then
		export PATH=$HOME/.mint/bin:$PATH
	fi

	# autojump (zoxide) init
	if [ -e "$(which zoxide)" ]; then
		eval "$(zoxide init zsh)"
	fi

	# flyctl (https://fly.io)
	if [ -e "$HOME/.fly/bin" ]; then
		export PATH=$HOME/.fly/bin:$PATH
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

	# macOS vs-code alias
	if [ -x /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ]; then
		alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
	fi

# Aliases
	type eza 2>&- >&- && alias ls="eza"

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
		eza;
	}


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
