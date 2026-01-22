.DEFAULT_GOAL := help
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
CONFIG_DIR := $(DOTFILES_DIR)/config
NAME := "dotfiles"
UNAME := "$(shell uname)"
XDG_CONFIG_HOME ?= $(HOME)/.config
BACKUP_DIR := $(HOME)/.dotfiles.backup.$(shell date +%Y%m%d_%H%M%S)

.PHONY: alacritty
## alacritty: 🖥️ Setup symlink for alacritty configuration
alacritty:
	@echo "🖥️  Setting up alacritty configuration..."
	@rm -rf $(XDG_CONFIG_HOME)/alacritty
	@ln -sf "$(CONFIG_DIR)/alacritty/$(UNAME)/alacritty.toml" "$(CONFIG_DIR)/alacritty/alacritty.toml"; \
	ln -sf "$(CONFIG_DIR)/alacritty" "$(XDG_CONFIG_HOME)/alacritty"
	@echo "✅ Alacritty configured!"

.PHONY: bashrc
## bashrc: 🐚 Setup symlink for .bashrc
bashrc:
	@echo "🐚 Setting up bash configuration..."
	@if [ ! -d "$(HOME)/.oh-my-bash" ]; then \
		echo "📥 Installing oh-my-bash..."; \
		git clone https://github.com/ohmybash/oh-my-bash.git $(HOME)/.oh-my-bash; \
	fi
	@rm -f $(HOME)/.bashrc.conf
	@ln -sf "$(CONFIG_DIR)/bash/.bashrc" "$(HOME)/.bashrc"
	@echo "✅ Bash configured!"

.PHONY: brew
## brew: 🍺 Install brew and brew packages
brew:
	@echo "🍺 Setting up Homebrew..."
	@if ! command -v brew >/dev/null 2>&1 && [ ! -f "$/home/linuxbrew/.linuxbrew/bin/brew" ]; then \
		echo "📥 Installing Homebrew..."; \
		if [ "$(UNAME)" = "Linux" ]; then \
			rm -rf "/home/linuxbrew/.linuxbrew/Homebrew"; \
			git clone https://github.com/Homebrew/brew "$/home/linuxbrew/.linuxbrew/Homebrew"; \
			mkdir -p "/home/linuxbrew/.linuxbrew/bin"; \
			ln -sf "/home/linuxbrew/.linuxbrew/Homebrew/bin/brew" "$/home/linuxbrew/.linuxbrew/bin/brew"; \
		elif [ "$(UNAME)" = "Darwin" ]; then \
			/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		fi; \
	else \
		echo "✔ Homebrew is already installed. Skipping install."; \
	fi
	@echo "📦 Installing packages from Brewfile..."
	@if [ "$(UNAME)" = "Darwin" ]; then \
		if [ -f "/opt/homebrew/bin/brew" ]; then \
			eval "$$(/opt/homebrew/bin/brew shellenv)"; \
		fi; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; \
	fi; \
	brewfile="requirements/$(UNAME)/Brewfile"; \
	brew bundle --file $$brewfile
	@echo "✅ Homebrew setup complete!"

.PHONY: config
## config: ⚙️  Setup user configuration
config:
	@echo "⚙️  Setting up user configuration..."
	@if [ "$(UNAME)" = "Linux" ]; then \
			$(MAKE) bashrc gitconfig nvim tmux; \
	elif [ "$(UNAME)" = "Darwin" ]; then \
			$(MAKE) zshrc gitconfig nvim tmux ghostty; \
	fi
	@echo "✅ Configuration complete!"

.PHONY: opencode
## opencode: 🤖 Setup symlink for OpenCode configuration
opencode:
	@echo "🤖 Setting up OpenCode configuration..."
	@rm -f $(XDG_CONFIG_HOME)/opencode/opencode.json
	@ln -sf "$(CONFIG_DIR)/opencode/opencode.json" $(XDG_CONFIG_HOME)/opencode/opencode.json
	@echo "✅ OpenCode configured!"

.PHONY: crush
## crush: 🎆 Setup symlink for crush configuration
crush:
	@echo "🤖 Setting up crush configuration..."
	@rm -rf $(XDG_CONFIG_HOME)/crush
	@ln -sf "$(CONFIG_DIR)/crush" "$(XDG_CONFIG_HOME)/crush"
	@echo "✅ Crush configured!"

.PHONY: fonts
## fonts: 🔤 Setup nerd fonts
fonts:
	@echo "🔤 Installing Nerd Fonts..."
	@if [ "$(UNAME)" = "Darwin" ]; then \
		FONTS_DIR="$(HOME)/Library/Fonts"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		FONTS_DIR="$(HOME)/.local/share/fonts"; \
	else \
		echo "❌ Unsupported OS: $(UNAME)"; exit 1; \
	fi; \
	cd /tmp && { \
		for FONT in JetBrainsMono; do \
			echo "📥 Downloading $$FONT..."; \
			wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$${FONT}.zip && \
			unzip -q $${FONT}.zip -d $${FONT} && \
			cp $${FONT}/*.ttf $${FONTS_DIR}/ && \
			rm -rf $${FONT}.zip $${FONT}; \
		done; \
		if [ "$(UNAME)" = "Linux" ]; then \
			echo "🔄 Refreshing font cache..."; \
			fc-cache -fv; \
		fi; \
	}
	@echo "✅ Fonts installed!"

.PHONY: gitconfig
## gitconfig: ⚙️ Setup symlink for gitconfig
gitconfig:
	@echo "⚙️  Setting up git configuration..."
	@rm -f $(HOME)/.gitconfig
	@ln -sf "$(CONFIG_DIR)/git/$(UNAME)/.gitconfig" "$(HOME)/.gitconfig"
	@rm -rf $(XDG_CONFIG_HOME)/gh-dash
	@ln -sf "$(CONFIG_DIR)/gh-dash" "$(XDG_CONFIG_HOME)/gh-dash"
	@echo "✅ Git configured!"

.PHONY: ghostty
## ghostty: 👻 Setup symlink for ghostty
ghostty:
	@echo "👻 Setting up ghostty configuration..."
	@rm -rf $(XDG_CONFIG_HOME)/ghostty
	@ln -sf "$(CONFIG_DIR)/ghostty" "$(XDG_CONFIG_HOME)/ghostty"
	@echo "✅ Ghostty configured!"

.PHONY: nvim
## nvim: 📝 Setup and install neovim configuration
nvim:
	@echo "📝 Setting up neovim configuration..."
	@rm -rf $(XDG_CONFIG_HOME)/nvim
	@rm -rf $(HOME)/.local/share/nvim
	@ln -sf "$(CONFIG_DIR)/nvim" "$(XDG_CONFIG_HOME)/nvim"
	@echo "📦 Installing Lazy plugins..."
	@nvim --headless +"Lazy! sync" +qa
	@echo "✅ Neovim configured!"

.PHONY: tmux
## tmux: 🖼️ Setup symlink for tmux configuration
tmux:
	@echo "🖼️ Setting up tmux configuration..."
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		echo "📥 Installing tmux plugin manager..."; \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	fi
	@rm -f $(HOME)/.tmux.conf
	@ln -sf "$(CONFIG_DIR)/tmux/$(UNAME)/.tmux.conf" "$(HOME)/.tmux.conf"
	@echo "✅ Tmux configured!"

.PHONY: zshrc
## zshrc: 🐚 Setup symlink for zsh configuration
zshrc:
	@echo "🐚 Setting up zsh configuration..."
	@if [ ! -d "$(HOME)/.oh-my-zsh" ]; then \
		echo "📥 Installing oh-my-zsh..."; \
		git clone https://github.com/ohmyzsh/ohmyzsh.git $(HOME)/.oh-my-zsh; \
	fi
	@if [ ! -d "$(HOME)/.oh-my-zsh/custom/themes/powerlevel10k" ]; then \
		echo "🎨 Installing powerlevel10k theme..."; \
		git clone https://github.com/romkatv/powerlevel10k.git $(HOME)/.oh-my-zsh/custom/themes/powerlevel10k; \
	fi
	@rm -rf $(HOME)/.zshrc
	@rm -rf $(HOME)/.p10k.zsh
	@ln -sf "$(CONFIG_DIR)/zsh/.zshrc" "$(HOME)/.zshrc"
	@ln -sf "$(CONFIG_DIR)/zsh/.p10k.zsh" "$(HOME)/.p10k.zsh"
	@echo "✅ Zsh configured!"

.PHONY: install
## install: 🚀 Complete setup (brew + fonts + config)
install:
	@echo "🚀 Starting full dotfiles installation..."
	@$(MAKE) brew
	@$(MAKE) fonts
	@$(MAKE) config
	@echo "✅ Installation complete!"

.PHONY: update
## update: 🔄 Update brew packages and plugin managers
update:
	@echo "📦 Updating Homebrew packages..."
	@brew update && brew upgrade
	@if [ "$(UNAME)" = "Darwin" ]; then \
		echo "🔧 Updating oh-my-zsh..."; \
		[ -d "$(HOME)/.oh-my-zsh" ] && cd $(HOME)/.oh-my-zsh && git pull || true; \
		echo "🎨 Updating powerlevel10k..."; \
		[ -d "$(HOME)/.oh-my-zsh/custom/themes/powerlevel10k" ] && \
			cd $(HOME)/.oh-my-zsh/custom/themes/powerlevel10k && git pull || true; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		echo "🔧 Updating oh-my-bash..."; \
		[ -d "$(HOME)/.oh-my-bash" ] && cd $(HOME)/.oh-my-bash && git pull || true; \
	fi
	@echo "🔌 Updating tmux plugin manager..."
	@[ -d "$(HOME)/.tmux/plugins/tpm" ] && cd $(HOME)/.tmux/plugins/tpm && git pull || true
	@echo "✅ Updates complete!"

.PHONY: doctor
## doctor: 🔍 Check if required tools are installed
doctor:
	@echo "🔍 Checking system dependencies..."
	@echo "\n📦 Homebrew packages:"
	@brewfile="requirements/$(UNAME)/Brewfile"; \
	if [ -f "$${brewfile}" ]; then \
		grep '^brew ' $${brewfile} | sed 's/brew "\(.*\)"/\1/' | while read -r pkg; do \
			pkg_name=$$(echo $$pkg | sed 's/.*\///'); \
			brew list $$pkg_name >/dev/null 2>&1 && echo "  ✅ $$pkg_name" || echo "  ❌ $$pkg_name"; \
		done; \
	else \
		echo "  ⚠️  Brewfile not found for $(UNAME)"; \
	fi
	@echo "\n🔧 Shell configurations:"
	@if [ "$(UNAME)" = "Darwin" ]; then \
		[ -d "$(HOME)/.oh-my-zsh" ] && echo "  ✅ oh-my-zsh" || echo "  ❌ oh-my-zsh"; \
		[ -d "$(HOME)/.oh-my-zsh/custom/themes/powerlevel10k" ] && echo "  ✅ powerlevel10k" || echo "  ❌ powerlevel10k"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		[ -d "$(HOME)/.oh-my-bash" ] && echo "  ✅ oh-my-bash" || echo "  ❌ oh-my-bash"; \
	fi
	@[ -d "$(HOME)/.tmux/plugins/tpm" ] && echo "  ✅ tmux plugin manager" || echo "  ❌ tmux plugin manager"
	@echo "\n🔗 Symlink status:"
	@if [ "$(UNAME)" = "Darwin" ]; then \
		ls -la $(HOME)/.zshrc 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .zshrc" || echo "  ❌ .zshrc"; \
		ls -la $(HOME)/.p10k.zsh 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .p10k.zsh" || echo "  ❌ .p10k.zsh"; \
		ls -la $(XDG_CONFIG_HOME)/ghostty 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ ghostty" || echo "  ❌ ghostty"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		ls -la $(HOME)/.bashrc 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .bashrc" || echo "  ❌ .bashrc"; \
	fi
	@ls -la $(HOME)/.gitconfig 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .gitconfig" || echo "  ❌ .gitconfig"
	@ls -la $(HOME)/.tmux.conf 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .tmux.conf" || echo "  ❌ .tmux.conf"
	@ls -la $(XDG_CONFIG_HOME)/nvim 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ nvim" || echo "  ❌ nvim"

.PHONY: backup
## backup: 💾 Backup existing configs before installation
backup:
	@echo "💾 Creating backup at $(BACKUP_DIR)..."
	@mkdir -p $(BACKUP_DIR)
	@[ -f "$(HOME)/.zshrc" ] && cp $(HOME)/.zshrc $(BACKUP_DIR)/ || true
	@[ -f "$(HOME)/.p10k.zsh" ] && cp $(HOME)/.p10k.zsh $(BACKUP_DIR)/ || true
	@[ -f "$(HOME)/.bashrc" ] && cp $(HOME)/.bashrc $(BACKUP_DIR)/ || true
	@[ -f "$(HOME)/.gitconfig" ] && cp $(HOME)/.gitconfig $(BACKUP_DIR)/ || true
	@[ -f "$(HOME)/.tmux.conf" ] && cp $(HOME)/.tmux.conf $(BACKUP_DIR)/ || true
	@[ -d "$(XDG_CONFIG_HOME)/nvim" ] && cp -r $(XDG_CONFIG_HOME)/nvim $(BACKUP_DIR)/ || true
	@[ -d "$(XDG_CONFIG_HOME)/alacritty" ] && cp -r $(XDG_CONFIG_HOME)/alacritty $(BACKUP_DIR)/ || true
	@[ -d "$(XDG_CONFIG_HOME)/ghostty" ] && cp -r $(XDG_CONFIG_HOME)/ghostty $(BACKUP_DIR)/ || true
	@echo "✅ Backup complete: $(BACKUP_DIR)"

.PHONY: clean
## clean: 🧹 Remove all symlinks
clean:
	@echo "🧹 Removing dotfile symlinks..."
	@rm -f $(HOME)/.zshrc $(HOME)/.p10k.zsh
	@rm -f $(HOME)/.bashrc
	@rm -f $(HOME)/.gitconfig
	@rm -f $(HOME)/.tmux.conf
	@rm -rf $(XDG_CONFIG_HOME)/nvim
	@rm -rf $(XDG_CONFIG_HOME)/alacritty
	@rm -rf $(XDG_CONFIG_HOME)/ghostty
	@echo "✅ Cleanup complete"

.PHONY: test
## test: 🧪 Test configuration files
test:
	@echo "🧪 Testing configurations..."
	@if [ "$(UNAME)" = "Darwin" ]; then \
		zsh -n $(CONFIG_DIR)/zsh/.zshrc && echo "✅ .zshrc syntax" || echo "❌ .zshrc syntax"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		bash -n $(CONFIG_DIR)/bash/.bashrc && echo "✅ .bashrc syntax" || echo "❌ .bashrc syntax"; \
	fi
	@nvim --headless +checkhealth +qa && echo "✅ nvim health check" || echo "❌ nvim health check"
	@tmux -f $(HOME)/.tmux.conf -C exit 2>/dev/null && echo "✅ tmux config" || echo "❌ tmux config"

.PHONY: help
## help: 📖 Show help message
help: Makefile
	@echo
	@echo " Choose a command to run in "$(NAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

