{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  username,
  ...
}: let
  mainMonitor = "eDP-1";
in {
  imports = with outputs.homeManagerModules; [
    hyprland_waybar
  ];

  home.packages = with pkgs; [
    # Screenshot and recording tools
    wayshot
    wf-recorder
    imagemagick
    slurp

    # Audio and video management
    pavucontrol
    playerctl
    pulseaudio

    # Display and input management
    wlr-randr
    brightnessctl
    hyprcursor
    xorg.xrdb
    wl-gammactl

    # Image and text processing
    tesseract
    swappy

    # Security and encryption
    gnupg

    # Bluetooth management
    blueberry

    # Clipboard management
    cliphist

    # Miscellaneous utilities
    glib
    wl-clipboard
    xdg-utils
    xwaylandvideobridge
    hyprpaper
    hyprpicker
    hyprsunset

    # fix
    hyprland-qtutils

  ];

  services.kdeconnect = {
    package = pkgs.kdePackages.kdeconnect-kde;
    enable = true;
    indicator = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ 
      "$HOME/Pictures/backgrounds/face/background1"
      "$HOME/Pictures/backgrounds/face/background2"
      ];
      wallpaper = [
      # "DP-2,$HOME/Pictures/background/face/background"
      "eDP-1,$HOME/Pictures/backgrounds/face/background1"
      ];
    };
  };

  # hyprlock configuration
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = "$HOME/Pictures/backgrounds/face/background";
          blur_passes = 2;
          color = "rgba(36, 39, 58, 1)";
        }
      ];
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      input-field = [
        {
          monitor = mainMonitor;
          size = "400, 70";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(179, 139, 202, 1)";
          inner_color = "rgba(54, 58, 79, 1)";
          font_color = "rgba(202, 211, 245, 1)";
          fade_on_empty = false;
          placeholder_text = "🔒 Enter Pass";
          hide_input = false;
          check_color = "rgba(145, 215, 227, 1)";
          fail_color = "rgba(237, 135, 150, 1)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "rgba(238, 212, 159, 1)";
          position = "0, -185";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
        }
      ];
      # # USER-BOX
      # shape = [
      #   {
      #     monitor = mainMonitor;
      #     size = "600, 120";
      #     color = "rgba(255, 255, 255, .1)";
      #     rounding = -1;
      #     border_size = 0;
      #     border_color = "rgba(253, 198, 135, 0)";
      #     rotate = 0;
      #     xray = false;

      #     position = "0, -65";
      #     halign = "center";
      #     valign = "center";
      #   }
      # ];
      # Avatar
      image = [
        {
          monitor = mainMonitor;
          path = "$HOME/Pictures/backgrounds/face/.face";  # 用户头像路径
          size = 350;
          border_color = "rgba(179, 139, 202, 1)";  # 使用 $accent 颜色
          rounding = -1;
          position = "0, 75";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
        }
      ];
      label = [
        # Day-Month-Date
        {
          monitor = mainMonitor;
          text = "cmd[update:43200000] echo \"$(date +\"%A, %d %B %Y\")\"";
          color = "rgba(202, 211, 245, 1)";
          font_size = 25;
          position = "-130, -250";
          halign = "right";
          valign = "top";
          shadow_passes = 2;
        }
        # Time
        {
          monitor = mainMonitor;
          text = "cmd[update:30000] echo \"$(date +\"%I:%M %p\")\"";
          color = "rgba(202, 211, 245, 1)";
          font_size = 90;
          position = "-130, -100";
          halign = "right";
          valign = "top";
          shadow_passes = 2;
        }
        # KEYBOARD LAYOUT
        {
          monitor = mainMonitor;
          text = "$LAYOUT";  # 动态显示键盘布局
          color = "rgba(202, 211, 245, 1)";  # 使用 $text 颜色
          font_size = 20;
          rotate = 0;  # 0度旋转
          position = "-130, -310";
          halign = "right";
          valign = "top";
          shadow_passes = 2;
        }
        # CURRENT SONG
        {
          monitor = mainMonitor;
          text = "cmd[update:1000] echo \"$(playerctl metadata --format '♫ {{title}} {{artist}}')\"";
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 36;
          position = "0, -50";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };

  # hypridle configuration
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "hyprctl dispatch dpms off";
        after_sleep_cmd = "hyprctl dispatch dpms on && loginctl lock-session";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 360;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 420;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  # hyprland configuration
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;
        settings = {
          env = [
            "XMODIFIERS, @im=fcitx"
            "QT_IM_MODULE, fcitx"
            "SDL_IM_MODULE, fcitx"
            "QT_QPA_PLATFORMTHEME, qt5ct"
            "GDK_BACKEND, wayland,x11"
            "QT_QPA_PLATFORM, wayland;xcb"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
            "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
            "CLUTTER_BACKEND, wayland"
            "ADW_DISABLE_PORTAL, 1"
            # "GDK_SCALE,2"
            "XCURSOR_SIZE, 24"
            "HYPRCURSOR_SIZE, 24"
          ];
          exec-once = [
            # xrdb dpi scale have batter effect in 4k screen
            "echo 'Xft.dpi: 192' | xrdb -merge"
            #"ags -b hypr"
            "waybar"
            "hyprsunset"
            "fcitx5 -d --replace"
            "hyprctl dispatch exec [workspace 7 silent] foot btop"
          ];
          monitor = [
            ",preferred,auto,auto"
            "${mainMonitor}, addreserved, 0, 0, 0, 0"
            "${mainMonitor}, highres,auto,2"
          ];
          input = {
            force_no_accel = false;
            kb_layout = "us";
            follow_mouse = 1;
            numlock_by_default = true;
            scroll_method = "2fg";

            touchpad = {
              natural_scroll = "yes";
              disable_while_typing = true;
              clickfinger_behavior = true;
              scroll_factor = 0.7;
            };
          };
          gestures = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = true;
            workspace_swipe_distance = 1200;
            workspace_swipe_fingers = 4;
            workspace_swipe_cancel_ratio = 0.2;
            workspace_swipe_min_speed_to_force = 5;
            workspace_swipe_create_new = true;
          };
          general = {
            gaps_in = 3;
            gaps_out = 6;
            border_size = 2;
            layout = "dwindle";
            no_focus_fallback = true;
            resize_on_border = true;
            "col.active_border" = "rgba(51a4e7ff)";
          };
          dwindle = {
            preserve_split = true;
          };
          decoration = {
            rounding = 10;
            shadow = {
              enabled = false;
              range = 8;
              render_power = 2;
              color = "rgba(00000044)";
            };
            # "col.shadow" = "rgba(00000044)";

            dim_inactive = false;

            blur = {
              enabled = false;
              size = 8;
              passes = 3;
              new_optimizations = "on";
              noise = 0.01;
              contrast = 0.9;
              brightness = 0.8;
              xray = true;
            };
          };
          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 5, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };
          xwayland = {
            force_zero_scaling = true;
          };
          misc = {
            vrr = 1;
            focus_on_activate = true;
            animate_manual_resizes = false;
            animate_mouse_windowdragging = false;
            #suppress_portal_warnings = true
            enable_swallow = true;
            key_press_enables_dpms = true;
            force_default_wallpaper = 0;
          };
          binds = {
            workspace_back_and_forth = true;
          };
          device = {
            name = "VXE R1SE";
            sensitivity = -0.5;
          };
          workspace = [
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
          ];
          windowrule = [
            "float, ^(steam)$"
            "tile,title:^(WPS)(.*)$"
            "tile,title:^(微信)(.*)$"
            "tile,title:^(钉钉)(.*)$"
            # Dialogs
            "float,title:^(Open File)(.*)$"
            "float,title:^(Open Folder)(.*)$"
            "float,title:^(Save As)(.*)$"
            "float,title:^(Library)(.*)$"
            "float,title:^(xdg-desktop-portal)(.*)$"
            "nofocus,title:^(.*)(mvi)$"
          ];
          windowrulev2 = [
            "opacity 0.0 override,class:^(xwaylandvideobridge)$"
            "noanim,class:^(xwaylandvideobridge)$"
            "nofocus,class:^(xwaylandvideobridge)$"
            "noinitialfocus,class:^(xwaylandvideobridge)$"
            "maxsize 1 1,class:^(xwaylandvideobridge)$"
            "bordersize 0, floating:0, onworkspace:w[tv1]"
            "rounding 0, floating:0, onworkspace:w[tv1]"
            "bordersize 0, floating:0, onworkspace:f[1]"
            "rounding 0, floating:0, onworkspace:f[1]"
          ];
          layerrule = [
            # "blur, powermenu"
            # "blur, gtk-layer-shell"
            # "ignorezero, gtk-layer-shell"
          ];
          # bind = let
          #   e = "exec, ags -b hypr";
          # in [
          bind = [
            "ControlSuper, Q, killactive,"
            "ControlSuper, Space, togglefloating, "
            "ControlSuperShift, Space, pin, "
            "ControlShiftSuper, Q, exec, hyprctl kill"
            "Super, Return, exec, foot"
            "Super, ESCAPE, exec, fish -c wlogout"
            "ControlSuperShiftAlt, E, exit,"
            # ", XF86PowerOff, ${e} -t powermenu"
            # "Super, Tab,     ${e} -t overview"
            # Snapshot
            # "SuperShift, S, exec, grim -g \"$(slurp)\" - | wl-copy"
            # "Super,Print,  ${e} -r 'recorder.start()'"
            # "ControlSuper,Print,  ${e} -r 'recorder.start(\"gif\", \"-c gif\")'"
            # "SuperShift, S,         ${e} -r 'recorder.screenshot(true)'"
            # "AltSuperShift, S,    ${e} -r 'recorder.screenshot()'"
            "ControlShiftSuper, P, exec, playerctl play-pause"
            "ControlAltSuper, P, exec, playerctl pause"
            "ControlShiftSuper, S, exec, playerctl pause"
            "ControlSuper, P, exec, playerctl previous"
            "ControlSuper, N, exec, playerctl next"
            "ControlSuperShiftAlt, L, exec, hyprlock"
            "ControlSuperShiftAlt, D, exec, systemctl poweroff"
            # launcher
            "Super, D, exec, rofi -show drun"
            #"Super, N, exec, ags -b hypr -t datemenu"
            # Swap windows
            "SuperShift, H, movewindow, l"
            "SuperShift, L, movewindow, r"
            "SuperShift, K, movewindow, u"
            "SuperShift, J, movewindow, d"
            # Move focus
            "Super, H, movefocus, l"
            "Super, L, movefocus, r"
            "Super, K, movefocus, u"
            "Super, J, movefocus, d"
            # Workspace, window, tab switch with keyboard
            "ControlSuper, right, workspace, +1"
            "ControlSuper, left, workspace, -1"
            "ControlSuper, BracketLeft, workspace, -1"
            "ControlSuper, BracketRight, workspace, +1"
            "ControlSuper, L, workspace, +1"
            "ControlSuper, H, workspace, -1"
            "ControlSuper, up, workspace, -5"
            "ControlSuper, down, workspace, +5"
            "Super, Page_Down, workspace, +1"
            "Super, Page_Up, workspace, -1"
            "ControlSuper, Page_Down, workspace, +1"
            "ControlSuper, Page_Up, workspace, -1"
            "SuperShift, Page_Down, movetoworkspace, +1"
            "SuperShift, Page_Up, movetoworkspace, -1"
            "ControlShiftSuper, L, movetoworkspace, +1"
            "ControlShiftSuper, H, movetoworkspace, -1"
            "AltSuper, L, movecurrentworkspacetomonitor, +1"
            "AltSuper, H, movecurrentworkspacetomonitor, -1"
            "SuperShift, mouse_down, movetoworkspace, -1"
            "SuperShift, mouse_up, movetoworkspace, +1"
            # Fullscreen
            "Super, F, fullscreen, 1"
            "SuperShift, F, fullscreen, 0"
            "ControlSuper, F, fullscreenstate, 3"
            # Switching
            "Super, 1, workspace, 1"
            "Super, 2, workspace, 2"
            "Super, 3, workspace, 3"
            "Super, 4, workspace, 4"
            "Super, 5, workspace, 5"
            "Super, 6, workspace, 6"
            "Super, 7, workspace, 7"
            "Super, 8, workspace, 8"
            "Super, 9, workspace, 9"
            "Super, 0, workspace, 10"
            "Super, S, togglespecialworkspace"
            "Alt, Tab, cyclenext"
            "Super, T, bringactivetotop"
            # "Super, C, togglespecialworkspace, kdeconnect"
            # "Super, Tab, exec, ags -b hypr -t overview"
            # Move window to workspace Control + Super + [0-9]
            "ControlSuper, 1, movetoworkspacesilent, 1"
            "ControlSuper, 2, movetoworkspacesilent, 2"
            "ControlSuper, 3, movetoworkspacesilent, 3"
            "ControlSuper, 4, movetoworkspacesilent, 4"
            "ControlSuper, 5, movetoworkspacesilent, 5"
            "ControlSuper, 6, movetoworkspacesilent, 6"
            "ControlSuper, 7, movetoworkspacesilent, 7"
            "ControlSuper, 8, movetoworkspacesilent, 8"
            "ControlSuper, 9, movetoworkspacesilent, 9"
            "ControlSuper, 0, movetoworkspacesilent, 10"
            "ControlShiftSuper, Up, movetoworkspacesilent, special"
            "ControlSuper, S, movetoworkspacesilent, special"
            # Scroll through existing workspaces with (Control) + Super + scroll
            "Super, mouse_up, workspace, +1"
            "Super, mouse_down, workspace, -1"
            "ControlSuper, mouse_up, workspace, +1"
            "ControlSuper, mouse_down, workspace, -1"
            # Move/resize windows with Super + LMB/RMB and dragging
            "ControlSuper, Backslash, resizeactive, exact 640 480"
          ];
          bindm = [
            # Move/resize windows with Super + LMB/RMB and dragging
            "Super, mouse:272, movewindow"
            "Super, mouse:273, resizewindow"
            "Super, mouse:274, movewindow"
            "Super, Z, movewindow"
          ];
          binde = [
            # Window split ratio
            "SUPER, Minus, splitratio, -0.1"
            "SUPER, Equal, splitratio, 0.1"
            "SUPER, Semicolon, splitratio, -0.1"
            "SUPER, Apostrophe, splitratio, 0.1"
          ];
          bindr = [
            # "SUPER,W,exec,killall -SIGUSR1 waybar;"
            # "SUPERSHIFT,W,exec,killall -SIGUSR2 waybar;"
            "ControlSuperShiftAlt, W, exec, killall waybar || waybar;"
          ];
          bindl = [
            # ",Print,exec,grim - | wl-copy"
            "ControlSuperShiftAlt, S, exec, systemctl suspend"
            ",XF86AudioPlay,    exec, playerctl play-pause"
            ",XF86AudioStop,    exec, playerctl pause"
            ",XF86AudioPause,   exec, playerctl pause"
            ",XF86AudioPrev,    exec, playerctl previous"
            ",XF86AudioNext,    exec, playerctl next"
            ",XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
          ];
          bindle = [
            ",XF86MonBrightnessUp,   exec, brightnessctl set +5%"
            ",XF86MonBrightnessDown, exec, brightnessctl set  5%-"
            ",XF86KbdBrightnessUp,   exec, brightnessctl -d asus::kbd_backlight set +1"
            ",XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set  1-"
            ",XF86AudioRaiseVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
            ",XF86AudioLowerVolume,  exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          ];
        };
      };
    };
  };
}
