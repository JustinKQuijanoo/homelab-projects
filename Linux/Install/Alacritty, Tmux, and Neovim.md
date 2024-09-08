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

## Start Nvim 
```bash
nvim
```
- When starting `nvim`, it should go through a one time only configuration set up nawm sayin

## Alacritty Customization

### `~/.config/alacritty/alacritty.toml`
```bash
import = ["/home/<USER>/.config/alacritty/alacritty/catppuccin-macchiator.toml"]

[colors]
draw_bold_text_with_bright_colors = true

[font]
size = 11

[env]
TERM = "xterm-256color"

[font.normal]
family = "JetBrainsMono NL"
style = "Regular"
```

### `~/.config/alacritty/catppuccin-macchiator.toml`
```bash
[colors.primary]
background = "#1E1E2E"
foreground = "#CDD6F4"
dim_foreground = "#CDD6F4"
bright_foreground = "#CDD6F4"

[colors.cursor]
text = "#1E1E2E"
cursor = "#F5E0DC"

[colors.vi_mode_cursor]
text = "#1E1E2E"
cursor = "#B4BEFE"

[colors.search.matches]
foreground = "#1E1E2E"
background = "#A6ADC8"

[colors.search.focused_match]
foreground = "#1E1E2E"
background = "#A6E3A1"

[colors.footer_bar]
foreground = "#1E1E2E"
background = "#A6ADC8"

[colors.hints.start]
foreground = "#1E1E2E"
background = "#F9E2AF"

[colors.hints.end]
foreground = "#1E1E2E"
background = "#A6ADC8"

[colors.selection]
text = "#1E1E2E"
background = "#F5E0DC"

[colors.normal]
black = "#45475A"
red = "#F38BA8"
green = "#A6E3A1"
yellow = "#F9E2AF"
blue = "#89B4FA"
magenta = "#F5C2E7"
cyan = "#94E2D5"
white = "#BAC2DE"

[colors.bright]
black = "#585B70"
red = "#F38BA8"
green = "#A6E3A1"
yellow = "#F9E2AF"
blue = "#89B4FA"
magenta = "#F5C2E7"
cyan = "#94E2D5"
white = "#A6ADC8"

[colors.dim]
black = "#45475A"
red = "#F38BA8"
green = "#A6E3A1"
yellow = "#F9E2AF"
blue = "#89B4FA"
magenta = "#F5C2E7"
cyan = "#94E2D5"
white = "#BAC2DE"

[[colors.indexed_colors]]
index = 16
color = "#FAB387"

[[colors.indexed_colors]]
index = 17
color = "#F5E0DC"
```
