# Setting Up

## Installing dependencies

Ensure that you have a working Nix (package manager not the OS) installation.
The following examples are for multi-user installations. For more info, check [here](https://nixos.org/download#nix-install-linux).

### Linux
```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Macos
```
sh <(curl -L https://nixos.org/nix/install)
```

Then add this to your shell configuration.
```
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
```

> Note: Put this in the .profile file to enable Nix before proceeding with the rest of the steps. Since the .zshrc file already contains this, you would not need to add this again after installing zsh shell.

## Install [Home Manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)
Add the appropriate channel.
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

Run the home manager installation command.
```
nix-shell '<home-manager>' -A install
```

## Install [NixGL](https://github.com/nix-community/nixGL)
To fix issues launching programs using OpenGL.
```
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault   # or replace `nixGLDefault` with your desired wrapper
```
Check [here](https://github.com/nix-community/nixGL?tab=readme-ov-file#nix-channel-recommended) for more info.

You can then run the program using `nixGL <program>` command.

## Updating the environment
1. Clone this inside your XDG config directory (which is usually ~/.config/).
2. Update your username and home path in the home.nix file.
3. Run `home-manager switch` to update the home manager environment.

### Changing the default shell to Zsh for Linux users
First, check that the zsh path is in valid login shells.
```
cat /etc/shells
```

If not, add the zsh path to /etc/shells, and change the shell.
```
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)
```
Login again for changes to take effect.

#### To get the fish-like autosuggestions:

Git clone zsh-autosuggestions repository.
```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
```
And start a new terminal session.

### Custom scripts/commands
`/bin` directory stores my custom shell commands. They are automatically linked to `$HOME/.local/bin/...`.

`$HOME/.local/bin` has already been added to the path, but you may still need to run `chmod +x <filename>` to make sure they have execution permissions.
