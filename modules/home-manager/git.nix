{
  username,
  pkgs,
  ...
}: {
  # git
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "${username}";
    userEmail = "QK180455052@outlook.com";
    extraConfig = {
      color.ui = true;
      credential.helper = "store";
      github.user = "WayLX-QK";
      push.autoSetupRemote = true;
      mergetool.keepBackup = false;
      merge.tool = "vimdiff";
      diff.tool = "vimdiff";
      core.autocrlf = "input";
    };
  };
}
