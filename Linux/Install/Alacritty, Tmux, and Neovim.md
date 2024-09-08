## Objectives
- Install Alacritty terminal emulator
- Install Tmux terminal multiplexer
- Install Neovim

## Install Alacritty
```bash
sudo snap install alacritty --classic
```

## Install Tmux
```bash
sudo apt install tmux -y
```

## Install Neovim
```bash
sudo snap install nvim --classic
```

## Clone NvChad into nvim config directory

### Create `~/.config/nvim` if not created
```bash
mkdir ~/.config/nvim
```

```bash
git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

```

## Install JetBrains mono nerd font
```bash
URL=https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
wget $URL
FONT_FILE=${URL##*/}
unzip $FONT_FILE -d ~/.fonts
fc-cache -fv
```

## Add nvim alias to `.bashrc`
```bash
sudo echo 'alias vim=nvim' | sudo tee -a ~/.bashrc
```

## Create directory for tmux config and tmux.conf file 
```bash
sudo mkdir -p $XDG_CONFIG_HOME/tmux 
sudo touch $XDG_CONFIG_HOME/tmux/tmux.conf 
```

## Add the following lines to `$XDG_CONFIG_HOME/tmux/tmux.conf`
```bash
set-option -sa terminal-overrides ",xterm*:Tc"
set -g mouse on

# Start windows and panes numbering at 1, not 0
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'dreamsofcode-io/catppuccin/tmux'
set -g default-terminal "xterm-256color"
set-option default-terminal "xterm-256color"
set-option -ga terminal-overrides ",xterm-256color:TC"
run '~/.tmux/plugins/tpm/tpm'
```

### Source the tmux.conf file 
```bash
tmux source ~/.config/tmux/tmux.conf
```

