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
    niri_waybar
  ];

	home.packages = with pkgs; [
    xwayland-satellite
    # Screenshot and recording tools
    # wayshot
    # wf-recorder
    imagemagick

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
    wl-clipboard

    # Miscellaneous utilities
    glib
    xdg-utils
    # xwaylandvideobridge
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

	systemd.user = {
    services = {

      # swaybg = {
      #   wantedBy = [ "niri.service" ];
      #   wants = [ "graphical-session.target" ];
      #   after = [ "graphical-session.target" ];
      #   serviceConfig = {
      #     ExecStart =
      #       let
      #         img = pkgs.fetchurl {
      #           url = "https://s3.nyaw.xyz/misskey//92772482-aef9-44e8-b1e2-1d49753a72fc.jpg";
      #           hash = "sha256-Y9TJ/xQQhqWq3t2wn1gS4NPGpuz1m7nu1ATcWWPKPW8=";
      #         };
      #       in
      #       "${lib.getExe pkgs.swaybg} -i ${img} -m fill";
      #     Restart = "on-failure";
      #   };
      # };

      wpaperd = {
        Unit = {
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
          Requisite = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.wpaperd}/bin/wpaperd";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "niri.service" ];
      };

      # waybar = {
      #   Unit = {
      #     After = [ "graphical-session.target" ];
      #     PartOf = [ "graphical-session.target" ];
      #     Requisite = [ "graphical-session.target" ];
      #   };
      #   Service = {
      #     ExecStart = "${pkgs.waybar}/bin/waybar";
      #     Restart = "on-failure";
      #   };
      #   Install.WantedBy = [ "niri.service" ];
      # };

      swayidle = {
        Unit = {
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
          Requisite = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 330 'niri msg action power-off-monitors' timeout 300 'swaylock -f' timeout 1800 'systemctl hibernate || systemctl poweroff' before-sleep 'swaylock -f' ";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "niri.service" ];
      };


    };
  };

  programs.swaylock = {
		enable = true;
		settings = {
      image = "$HOME/Pictures/backgrounds/wallpapers/other/RetroVera.jpg";
      # color = "808080";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
		};
	};

  # services.swayidle = {
  #   enable = true;
  #   timeouts = [
  #     # {
  #     #   timeout = 295;
  #     #   command = "${pkgs.dunst}/bin/dunstify -t 5000 'Locking in 5 seconds'";
  #     # }
  #     {
  #       timeout = 300;
  #       command = "${pkgs.swaylock}/bin/swaylock -fF";
  #     }
  #     {
  #       timeout = 330;
  #       command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
  #       resumeCommand = "${pkgs.niri}/bin/niri msg action power-off-monitors";
  #     }
	# 		{
	# 			timeout = 360;
	# 			command = "${pkgs.systemd}/bin/systemctl suspend"; 
	# 		}
  #     {
	# 			timeout = 3600;
	# 			command = "${pkgs.systemd}/bin/systemctl hibernate || ${pkgs.systemd}/bin/systemctl poweroff"; 
	# 		}
  #   ];
  #   events = [
  #     {
  #       event = "before-sleep";
  #       command = "${pkgs.swaylock}/bin/swaylock -fF";
  #     }
  #   ];
  # };
}