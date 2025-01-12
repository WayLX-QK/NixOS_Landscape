{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = with outputs.homeManagerModules; [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    #hyprland
    #sway
    niri
    fcitx5
    theme
    mpv
    foot
    fuzzel
    vscode
    aria2
    mpd
    #dunstrc
    mako

    kali
    printing
    
  ];

  # nixpkgs.config.permittedInsecurePackages = [
  #   "openssl-1.1.1w"
  # ];

  gtk.gtk3.bookmarks = let
    homePath = "file://${config.home.homeDirectory}";
  in [
    "${homePath}/Documents"
    "${homePath}/Downloads"
    "${homePath}/Music"
    "${homePath}/Pictures"
    "${homePath}/Public"
    "${homePath}/Repo"
    "${homePath}/Templates"
    "${homePath}/Videos"
  ];

  home.packages = with pkgs; [
    qutebrowser
    firefox
    obs-studio
    scrcpy
    rustdesk-flutter
    # libreoffice
    wireshark
    mitmproxy
    # waydroid
    bottles
    telegram-desktop
    #discord
    # showmethekey
    # dbeaver-bin
    # redisinsight
    # wechat-uos
    # qq
    # wemeet
    # nur.repos.xddxdd.dingtalk
    # nur.repos.novel2430.wpsoffice-365
  ];
}
