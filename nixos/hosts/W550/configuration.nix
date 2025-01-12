# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = with outputs.nixosModules; [
    # If you want to use modules your own flake exports (from modules/nixos):
    adb
    printing
    Analytics
    flatpak
    screen
    security
    # swap

    firewall
    virt
    laptop-sleep
    systemd-boot
    fonts
    #hyprland
    #sway
    linux-kernel
    niri
    #cosmic
    gnome
    bluetooth
    theme

    radeon

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-gpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    #./hardware-configuration.nix
  ];

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # programs.kdeconnect = {
  #   package = pkgs.kdePackages.kdeconnect-kde;
  #   enable = true;
  # };

  services.fwupd.enable = true;

  services = {
    printing.enable = true;
    flatpak.enable = true;
    # auto-cpufreq = {
    #   enable = true;
    #   settings = {
    #     battery = {
    #       governor = "powersave";
    #       turbo = "never";
    #     };
    #     charger = {
    #       governor = "performance";
    #       turbo = "auto";
    #     };
    #   };
    # };
    # tlp = {
    #   enable = true;
    #   settings = {
    #     RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
    #     RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";
    #     RADEON_DPM_STATE_ON_AC = "performance";
    #     RADEON_DPM_STATE_ON_BAT = "battery";
    #   };
    # };
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "org.codeberg.dnkl.foot.desktop"
      ];
    };
  };

  networking.hostName = "W550";
}
