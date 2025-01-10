{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  username,
  ...
}:{
  imports = with outputs.homeManagerModules; [
    sway_waybar
  ];

	# systemd.user = {
  #   targets.sway-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  # };

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
    # hyprcursor
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
    # hyprpaper
    # hyprpicker
    # hyprsunset

    # fix
    #hyprland-qtutils

		#hyprpicker
		#hyprcursor
		swaylock
		#swayidle
		#swaybg
		# wpaperd

		starship

		qutebrowser
		zathura
  ];

# 	services.kdeconnect = {
#     package = pkgs.kdePackages.kdeconnect-kde;
#     enable = true;
#     indicator = true;
#   };

	programs.wpaperd = {
		enable = true;
		settings = {
			default = {
				duration = "15m";
        		mode = "center";
      		};
      		any = {
				path = "${config.home.homeDirectory}/Pictures/backgrounds/wallpapers";
				apply-shadow = true;
			};
			eDP-1 = {
				path = "${config.home.homeDirectory}/Pictures/backgrounds/wallpapers";
				apply-shadow = true;
			};
			# DP-2 = {
			# 	path = "$HOME/Pictures/backgrounds";
			# 	sorting = "descending";
			# };
		};
	};

	systemd.user.services.wpaperd = {
		Unit = {
			After = [ "sway-session.target" ];
			PartOf = [ "sway-session.target" ];
		};
		Service = {
			ExecStart = "${pkgs.wpaperd}/bin/wpaperd";
			Restart = "on-failure";
		};
		Install.WantedBy = [ "sway-session.target" ];
	};

	programs.swaylock = {
		enable = true;
		# package = pkgs.swaylock-effects;
		settings = {
			# daemonize = true;
			# clock = true;
			# timestr = "%k:%M";
			# datestr = "%Y-%m-%d";
			# show-failed-attempts = true;
			color = "808080";
			font-size = 24;
			indicator-idle-visible = false;
			indicator-radius = 100;
			line-color = "ffffff";
			show-failed-attempts = true;
		};
		# // (lib.optionalAttrs (config.etu.graphical.sway.lockWallpaper == "screenshot") {
		# 	indicator = true;
		# 	screenshots = true;
		# 	effect-blur = "5x5";
		# })
		# // (lib.optionalAttrs (config.etu.graphical.sway.lockWallpaper != "screenshot") {
		# 	image = config.etu.graphical.sway.lockWallpaper;
		# });
	};

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 295;
        command = "${pkgs.dunst}/bin/dunstify -t 5000 'Locking in 5 seconds'";
      }
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 360;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
			{
				timeout = 390;
				command = "${pkgs.systemd}/bin/systemctl suspend"; 
			}
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
    ];
  };

  systemd.user.services.swayidle.Unit.PartOf = [ "sway-session.target" ];

  # home = {
  #   sessionVariables = {
  #     EDITOR = "nvim";
  #     BROWSER = "firefox";
  #     TERMINAL = "kitty";

  #     QT_QPA_PLATFORMTHEME = "gtk3";
  #     QT_SCALE_FACTOR = "1";
  #     SDL_VIDEODRIVER = "wayland";
  #     _JAVA_AWT_WM_NONREPARENTING = "1";
  #     QT_QPA_PLATFORM = "wayland";
  #     QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  #     QT_AUTO_SCREEN_SCALE_FACTOR = "1";

  #     XDG_CURRENT_DESKTOP = "Hyprland";
  #     XDG_SESSION_DESKTOP = "Hyprland";
  #     XDG_SESSION_TYPE = "wayland";
  #     XDG_CACHE_HOME = "\${HOME}/.cache";
  #     XDG_CONFIG_HOME = "\${HOME}/.config";
  #     XDG_BIN_HOME = "\${HOME}/.local/bin";
  #     XDG_DATA_HOME = "\${HOME}/.local/share";
  #   };
  #   sessionPath = [
  #     #"$HOME/.npm-global/bin"
  #     #"$HOME/.local/bin"
  #     #"$HOME/Codelearning/go/bin"
  #   ];
  # };
	wayland = {
		windowManager = {
			sway = {
				enable = true;
				xwayland = true;
				package = pkgs.sway;
				wrapperFeatures = {
					base = true;
					gtk = true;
				};
				# export QT_FONT_DPI=192
				# export WLR_XWAYLAND_SCALE=2
				extraSessionCommands = ''
					export XMODIFIERS=@im=fcitx
					export QT_IM_MODULE=fcitx
					export SDL_IM_MODULE=fcitx
					export QT_QPA_PLATFORMTHEME=qt5ct
					export GDK_BACKEND=wayland,x11
					export QT_QPA_PLATFORM=wayland;xcb
					export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
					export QT_AUTO_SCREEN_SCALE_FACTOR=1
					export CLUTTER_BACKEND=wayland
					export ADW_DISABLE_PORTAL=1
					export XCURSOR_SIZE=24
					export _JAVA_AWT_WM_NONREPARENTING=1
					export XDG_CURRENT_DESKTOP=sway
					
				'';

				config = rec {
					modifier = "Mod4";
					terminal = "foot";

					startup = [
						# { command = "swaybg -m fill -i $HOME/Pictures/face/background"; }
						# { command = "waybar"; }
						# { command = "fcitx5 -d --replace"; }
						{ command = "foot btop"; }
					];

					bars = [{ command = "waybar"; }];

					gaps = {
						outer = 6;
						inner = 3;
					};

					window = {
						border = 2;
					};

					# output = {
					# 	"eDP-1".scale = "2";
					# };

					keybindings = {
						"${modifier}+Return" = "exec ${terminal}";
						"${modifier}+D" = "exec rofi -show drun";
						"${modifier}+Q" = "exec qutebrowser";
						"${modifier}+Shift+Q" = "kill";
						"${modifier}+Escape" = "exec wlogout";
						"${modifier}+L" = "exec swaylock";
						"${modifier}+F" = "fullscreen";
					};

					# gestures = {
					# 	swipe_up = "workspace prev";
					# 	swipe_down = "workspace next";
					# };

					# input = {
					# 	"type:touchpad" = {
					# 		natural_scroll = true;
					# 		tap = true;
					# 		drag = true;
					# 		click_method = "clickfinger";
					# 	};
					# 	kb_layout = "us";
					# 	numlock_by_default = true;
					# };
				};

				extraConfig = ''
					workspace_auto_back_and_forth yes

					# Blur settings for specific apps
					for_window [app_id="foot"] blur enable

					# Decorations
					default_border pixel 2px
					default_floating_border none
					titlebar_border_thickness 0
				'';

				systemd = {
					enable = true;
					xdgAutostart = false;
				};
			};
		};
	};
}