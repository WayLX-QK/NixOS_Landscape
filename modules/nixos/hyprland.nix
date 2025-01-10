{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  # can't work with custom gnome module from ./gnome.nix
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # programs.nautilus-open-any-terminal = {
  #   enable = true;
  #   terminal = "foot";
  # };
  programs = {
    thunar.enable = true;
    xfconf.enable = true;
    dconf.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Display Manager and Login Screen
    greetd.tuigreet

    # Magnification and Accessibility
    loupe

    # Icon Themes
    adwaita-icon-theme
    flat-remix-gtk
    flat-remix-gnome
    flat-remix-icon-theme
    material-design-icons

    # Bluetooth Support
    bluez-alsa
    bluez

    # PolicyKit Integration
    lxqt.lxqt-policykit

    # Window Management and Status Bar
    waybar
    rofi-wayland
    wlogout

    # Brightness Control
    brightnessctl

    # Accessibility and Assistive Technologies
    at-spi2-atk

    # Qt Wayland Support
    qt6.qtwayland

    # Notifications
    psi-notify
    poweralertd

    # Multimedia Control
    pavucontrol
    playerctl
    alsa-utils

    # Image Manipulation
    imagemagick
    gifsicle

    # Screen Recording and Screenshots
    wl-screenrec
    wl-gammactl
    # wayshot
    grim
    slurp

    # Clipboard Management
    wl-clipboard
    wl-clip-persist
    cliphist

    # Text Input and Keyboard Shortcuts
    wtype
    wlrctl

    # Notification Daemon
    dunst

    # Miscellaneous Utilities
    psmisc
    xdg-utils
    swappy

  ];

  systemd = {
    user.services.polkit-lxqt = {
      description = "polkit-lxqt";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";
  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
  };

  services = {
    geoclue2.enable = true;
    tumbler.enable = true;
    devmon.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;
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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d '/var/cache/greeter' - greeter greeter - -"
  ];

}
