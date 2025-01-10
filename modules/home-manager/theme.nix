{pkgs, ...}: {
  # services = {
  #   xsettingsd = {
  #     enable = true;
  #     settings = {
  #       "Gdk/UnscaledDPI" = 98304;
  #       "Gdk/WindowScalingFactor" = 2;
  #     };
  #   };
  # };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      #gtk-theme = "Flat-Remix-GTK-Dark";
      #icon-theme = "Flat-Remix-Blue-Dark";
      color-scheme = "prefer-dark";
      font-name = "Sans 11";
      monospace-font-name = "Monospace 10";
      document-font-name = "Sans 11";
    };
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Sans Bold 11";
    };
  };
  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
    };
    platformTheme.name = "adwaita";
  };
  # 设置图标主题

  gtk = {
    enable = true;
    theme = {
      name = "flat-remix-gtk-dark";
      package = pkgs.flat-remix-gtk;
    };
    iconTheme = {
      package = pkgs.flat-remix-icon-theme;
      name = "Flat-Remix";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      # gtk-dialogs-use-header = false;
      # gtk-cursor-theme-size = 0;
      # gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
      # gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      # gtk-button-images = 0;
      # gtk-menu-images = 0;
      # gtk-enable-event-sounds = 0;
      # gtk-enable-input-feedback-sounds = 1;
      # gtk-xft-antialias = 1;
      # gtk-xft-hinting = 1;
      # gtk-xft-hintstyle = "hintslight";
      # gtk-xft-rgba = "none";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
