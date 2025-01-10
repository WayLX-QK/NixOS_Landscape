{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    xserver.enable = true;
    xserver.displayManager.lightdm.enable = true;
    #displayManager.cosmic-greeter.enable = true;
    xserver.desktopManager.cinnamon.enable = true;
    # xserver.desktopManager.deepin.enable = true;
    # desktopManager.cosmic = {
    #   enable = true;
    # };
  };
  services = {
    # sysprof.enable = false;
    flatpak.enable = true;
  };
}
