{ ... }: {
  programs.git = {
    enable = true;

    userName = "brianaung";
    userEmail = "brianaung16@gmail.com";

    aliases = {
      ci = "commit -v";
      co = "checkout";
      st = "status";
      br = "branch";
      unstage = "reset HEAD --";
      uncommit = "reset --soft HEAD~1";
      last = "log -1 HEAD";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative";
    };

    extraConfig = {
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
      push = {
        default = "current";
      };
      pull = {
        default = "current";
      };
      merge = {
        tool = "nvimdiff2";
      };
      diff = {
        tool = "nvimdiff";
      };
      mergetool = {
        keepBackup = false;
      };
    };
  };
}
