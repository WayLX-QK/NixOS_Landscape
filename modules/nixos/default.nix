# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  Analytics = import ./Analytics.nix;
  adb = import ./adb.nix;
  radeon = import ./radeon.nix;
  firewall = import ./firewall.nix;
  virt = import ./virt.nix;
  linux-kernel = import ./linux-kernel.nix;
  docker = import ./docker.nix;
  printing = import ./printing.nix;
  podman = import ./podman.nix;
  laptop-sleep = import ./laptop-sleep.nix;
  systemd-boot = import ./systemd-boot.nix;
  fonts = import ./fonts.nix;
  xserver = import ./xserver.nix;
  cosmic = import ./cosmic.nix;
  gnome = import ./gnome.nix;
  hyprland = import ./hyprland.nix;
  sway = import ./sway.nix;
  sing-box = import ./sing-box.nix;
  bluetooth = import ./bluetooth.nix;
  waydroid = import ./waydroid.nix;
  ollama = import ./ollama.nix;
  mihomo = import ./mihomo.nix;
  flatpak = import ./flatpak.nix;
  screen = import ./screen.nix;
  security = import ./security.nix;
  swap = import ./swap.nix;
  theme = import ./theme.nix;
  niri = import ./niri.nix;
}
