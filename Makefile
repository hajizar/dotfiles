DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
CONFIG_DIR := $(DOTFILES_DIR)/config
NAME := "dotenv"
UNAME := "$(shell uname)"
XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: alacritty
## alacritty: Setup symlink for alacritty configuration
alacritty:
	rm -rf $(XDG_CONFIG_HOME)/alacritty
	ln -sf "$(CONFIG_DIR)/alacritty/$(UNAME)/alacritty.toml" "$(CONFIG_DIR)/alacritty/alacritty.toml"; \
	ln -sf "$(CONFIG_DIR)/alacritty" "$(XDG_CONFIG_HOME)/alacritty"

.PHONY: bashrc
## bashrc: Setup symlink for .bashrc
bashrc:
	if [ ! -d "$(HOME)/.oh-my-bash" ]; then \
		git clone https://github.com/ohmybash/oh-my-bash.git $(HOME)/.oh-my-bash; \
	fi
	rm -f $(HOME)/.bashrc.conf
	ln -sf "$(CONFIG_DIR)/bash/.bashrc" "$(HOME)/.bashrc"

.PHONY: brew
## brew: Install brew and brew packages
brew:
	@which brew >/dev/null 2>&1 || { \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	}
	@if [ "$(UNAME)" = "Darwin" ]; then \
		export PATH="/opt/homebrew/bin:$(PATH)"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; \
	fi; \
	brewfile="requirements/$(UNAME)/Brewfile"; \
	brew bundle --file $${brewfile}
	
.PHONY: config
## config: Setup user configuration
config:
	if [ "$(UNAME)" = "Linux" ]; then \
			$(MAKE) bashrc gitconfig nvim tmux; \
	elif [ "$(UNAME)" = "Darwin" ]; then \
			$(MAKE) zshrc gitconfig nvim tmux ghostty; \
	fi

.PHONY: fonts
## fonts: Setup nerd fonts
fonts:
	@if [ "$(UNAME)" = "Darwin" ]; then \
		FONTS_DIR="$(HOME)/Library/Fonts"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		FONTS_DIR="$(HOME)/.local/share/fonts"; \
	else \
		echo "Unsupported OS: $(UNAME)"; exit 1; \
	fi; \
	cd /tmp && { \
		for FONT in JetBrainsMono; do \
			wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$${FONT}.zip && \
			unzip $${FONT}.zip -d $${FONT} && \
			cp $${FONT}/*.ttf $${FONTS_DIR}/ && \
			rm -rf $${FONT}.zip $${FONT}; \
		done; \
		if [ "$(UNAME)" = "Linux" ]; then \
			fc-cache -fv; \
		fi; \
	}

.PHONY: gitconfig
## gitconfig: Setup symlink for gitconfig
gitconfig:
	rm -f $(HOME)/.gitconfig
	ln -sf "$(CONFIG_DIR)/git/.gitconfig" "$(HOME)/.gitconfig"

.PHONY: ghostty
## ghostty: Setup symlink for ghostty
ghostty:
	rm -rf $(XDG_CONFIG_HOME)/ghostty
	ln -sf "$(CONFIG_DIR)/ghostty" "$(XDG_CONFIG_HOME)/ghostty"

.PHONY: nvim
## nvim: Setup neovim configuration
nvim:
	rm -rf $(XDG_CONFIG_HOME)/nvim
	ln -sf "$(CONFIG_DIR)/nvim" "$(XDG_CONFIG_HOME)/nvim"
	if [ "$(UNAME)" = "Linux" ]; then \
		sudo ln -sf "$(CONFIG_DIR)/nvim" "/root/.config/nvim"; \
	fi
	nvim --headless +"Lazy! restore" +qa

.PHONY: tmux
## tmux: Setup symlink for tmux configuration
tmux:
	if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	fi
	rm -f $(HOME)/.tmux.conf
	ln -sf "$(CONFIG_DIR)/tmux/$(UNAME)/.tmux.conf" "$(HOME)/.tmux.conf"

.PHONY: zshrc
## zshrc: Setup symlink for zsh configuration
zshrc:
	if [ ! -d "$(HOME)/.oh-my-zsh" ]; then \
		git clone https://github.com/ohmyzsh/ohmyzsh.git $(HOME)/.oh-my-zsh; \
	fi
	if [ ! -d "$(HOME)/.oh-my-zsh/custom/themes/powerlevel10k" ]; then \
		git clone https://github.com/romkatv/powerlevel10k.git $(HOME)/.oh-my-zsh/custom/themes/powerlevel10k; \
	fi
	rm -rf $(HOME)/.zshrc
	rm -rf $(HOME)/.p10k.zsh
	ln -sf "$(CONFIG_DIR)/zsh/.zshrc" "$(HOME)/.zshrc"
	ln -sf "$(CONFIG_DIR)/zsh/.p10k.zsh" "$(HOME)/.p10k.zsh"

.PHONY: help
## help: Show help message
help: Makefile
	@echo
	@echo " Choose a command to run in "$(NAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

