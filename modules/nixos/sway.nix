{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

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

  # environment.variables = {
  #   XDG_CURRENT_DESKTOP = "sway";
  #   QT_QPA_PLATFORM = "wayland";
  #   QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  #   _JAVA_AWT_WM_NONREPARENTING = "1";
  #   WLR_XWAYLAND_SCALE = "1";
  #   SDL_VIDEODRIVER = "wayland";
  #   GTK_IM_MODULE = "wayland";
  #   XCURSOR_THEME = "default";
  #   XCURSOR_SIZE = "24";
  # };

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
    dbus.enable = true;
    dbus.packages = with pkgs; [
      xfce.xfconf
      gnome2.GConf
    ];
  };

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

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd sway";
        user = "greeter";
      };
    };
  };

	systemd.tmpfiles.rules = [
    "d '/var/cache/greeter' - greeter greeter - -"
  ];
}