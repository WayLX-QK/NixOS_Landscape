{
  config,
  pkgs,
  username,
  inputs,
  lib,
  ...
}: {
  programs.niri = {
    # aligh waybar rpc etc
    package = pkgs.niri;
    enable = true;
  };

	programs = {
    thunar.enable = true;
    xfconf.enable = true;
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    # xwayland-satellite-unstable
    # Display Manager and Login Screen
    greetd.tuigreet

    wayland-utils
    libsecret
    libnotify
    cage
    gamescope      
    swaylock

    # # Icon Themes
    # adwaita-icon-theme
    # flat-remix-gtk
    # flat-remix-gnome
    # flat-remix-icon-theme
    # material-design-icons

    # Bluetooth Support
    bluez-alsa
    bluez

    # PolicyKit Integration
    polkit_gnome

    # Window Management and Status Bar
    waybar
    # rofi-wayland
    wlogout

    # Brightness Control
    brightnessctl

    # Accessibility and Assistive Technologies
    at-spi2-atk

    # Qt Wayland Support
    qt6.qtwayland

    # Notifications
    poweralertd

    # Multimedia Control
    pavucontrol
    playerctl
    alsa-utils

    # Image Manipulation
    imagemagick
    gifsicle

    # Screen Recording and Screenshots
    # wl-screenrec

    # Clipboard Management
    cliphist
    wl-clipboard

    # Text Input and Keyboard Shortcuts
    wtype
    wlrctl

    # Notification Daemon
    mako
    #dunst

    # Miscellaneous Utilities
    psmisc
    xdg-utils
    swappy
  ];

  security = {
    polkit.enable = true;
    pam.services.swaylock = {};
  };

  services = {
    geoclue2.enable = true;
    tumbler.enable = true;
    devmon.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;
    dbus.implementation = "broker";
    dbus.enable = true;
    dbus.packages = with pkgs; [
      xfce.xfconf
      gnome2.GConf
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };
    };
  };

	systemd.tmpfiles.rules = [
    "d '/var/cache/greeter' - greeter greeter - -"
  ];

  # services.greetd = {
  #   enable = true;
  #   vt = 2;
  #   settings = rec {
  #     initial_session = {
  #       command = "${lib.getExe pkgs.greetd.tuigreet} --remember --time --cmd ${lib.getExe' pkgs.niri "niri-session"}";
  #       inherit user;
  #     };
  #     default_session = initial_session;
  #   };
  # };


  systemd.user = {
    services = {
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
      };
      # xwayland-satellite = {
      #   wantedBy = [ "niri.service" ];
      #   after = [ "graphical-session.target" ];
      #   wants = [ "graphical-session.target" ];
      #   serviceConfig = {
      #     ExecStart = lib.getExe pkgs.xwayland-satellite;
      #     Restart = "on-failure";
      #   };
      # };
    };
  };
}