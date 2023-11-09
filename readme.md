# config_manager

## About

My configuration files for easy setup. Feel free to copy whatever you'd like, or follow the steps below to replicate my setup.

Always a WIP :)

## Setup

### Installing dependencies

Ensure that you have a working Nix installation.
The following examples are for multi-user installations. For more info, check [here](https://nixos.org/download#nix-install-linux).

#### Linux

```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

#### Macos

```
sh <(curl -L https://nixos.org/nix/install)
```

Then add this to your shell configuration.

```
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
```

> Note: Put this in the .profile file to enable Nix before proceeding with the rest of the steps. Since the .zshrc file already contains this, you would not need to add this again after installing zsh shell.

### Install [Home Manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)

Add the appropriate channel.

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

Run the home manager installation command.

```
nix-shell '<home-manager>' -A install
```

### Updating the environment

1. Clone this inside your XDG config directory (which is usually ~/.config/).

2. Then rename it from `config_manager` to `home-manager` (I will rename this repo in the future so we can omit this step).

3. Update your username and home path in the home.nix file.

4. Run `home-manager switch` to update the home manager environment.

#### Changing the default shell to Zsh for Linux users

First, check that the zsh path is in valid login shells.

```
cat /etc/shells
```

If not, add the zsh path to /etc/shells, and change the shell.

```
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)
```

Logout and login again for changes to take effect.

### Node

Installing NVM and node.

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
nvm install node
```

### Zsh

To get the fish-like autosuggestions:

1. Git clone zsh-autosuggestions repository.

```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```

2. And start a new terminal session.

### Git

Don't forget to update the `.gitconfig` using your credentials (should hide them but nah who cares).

### Local scripts/commands

`/bin` directory stores my custom shell commands. They are automatically linked to `$HOME/.local/bin/...`.

`$HOME/.local/bin` has already been added to the path, but you may still need to run `chmod +x <filename>` to make sure they have execution permissions.

### My favourite keybindings for command line

- `Ctrl-f`: Opens up a fzf session searching through `work`, `projects`,and `playground` directories. It will then send the selected directory to tmux for it to either create or attach to an existing session.
- `Ctrl-r`: Fuzzy find and paste the selected command line history.
- `Ctrl-t`: Fuzzy find and paste the selected files and directories.
- `Ctrl-y`: Accept suggestion.
