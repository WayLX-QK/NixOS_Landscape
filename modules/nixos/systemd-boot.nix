{
  lib,
  config,
  pkgs,
  ...
}:{
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/BOOT";
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
        consoleMode = "keep";
      };
    };
    initrd = {
      enable = true;
      systemd.enable = true;
    };
    consoleLogLevel = 3;
    plymouth = {
      enable = true;
      font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
      themePackages = [ pkgs.catppuccin-plymouth ];
      theme = "catppuccin-macchiato";
    };
  };
}
