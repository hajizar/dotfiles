#!/bin/bash
sudo apt update
# Installing oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
# Installing nvim
sudo snap -y install nvim --classic

