# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  hyprland = import ./hyprland.nix;
  sway = import ./sway.nix;
  hyprland_waybar = import ./hyprland_waybar.nix;
  sway_waybar = import ./sway_waybar.nix;
  fish = import ./fish.nix;
  foot = import ./foot.nix;
  neovim = import ./neovim.nix;
  git = import ./git.nix;
  fcitx5 = import ./fcitx5.nix;
  theme = import ./theme.nix;
  ctags = import ./ctags.nix;
  yazi = import ./yazi.nix;
  mpv = import ./mpv.nix;
  git-sync = import ./git-sync.nix;
  lang = import ./lang.nix;
  btop = import ./btop.nix;
  vscode = import ./vscode.nix;
  direnv = import ./direnv.nix;
  translate-shell = import ./translate-shell.nix;
  aria2 = import ./aria2.nix;
  starship = import ./starship.nix;
  ripgrep = import ./ripgrep.nix;
  mpd = import ./mpd.nix;
  printing = import ./printing.nix;
  fastfetch = import ./fastfetch.nix;
  kali = import ./kali.nix;
  dunstrc = import ./dunstrc.nix;
  mako = import ./mako.nix;
  niri = import ./niri.nix;
  niri_waybar = import ./niri_waybar.nix;
  alacritty = import ./alacritty.nix;
  fuzzel = import ./fuzzel.nix;
}
