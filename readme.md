# config_manager
## About
This houses the configurations for most of the development tools that I use. I use this to quickly setup my environment whenever I need to work on a new device, so I tried to make this as minimal as I can. Feel free to copy whatever you'd like, or follow the steps below if you want to replicate my setup.

My current tools:
- Neovim
- Tmux
- Zsh with Starship

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
Run `home-manager switch` to update the home manager environment.

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
Installing NVM.
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
```
Installing Node and other global packages.
```
nvm install node
npm i -g yarn
npm i -g vscode-langservers-extracted
npm i -g typescript typescript-language-server
```

### Git
Don't forget to update the `.gitconfig` using your credentials.
