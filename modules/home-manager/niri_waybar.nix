{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    waybar
    fuzzel
    # wlogout
  ];
  #:24 font-family: "Maple Mono NF CN";
  programs.waybar = {
    enable = true;
    # package = inputs.nixpkgs-wayland.packages.${pkgs.system}.waybar;
    systemd = {
      enable = true; # disable it,autostart it in sway conf
      target = "graphical-session.target";
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12pt;
        font-weight: bold;
        border-radius: 0px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      @keyframes blink_red {
        to {
          background-color: rgb(242, 143, 173);
          color: rgb(26, 24, 38);
        }
      }

      .warning,
      .critical,
      .urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      window#waybar {
        background-color: transparent;
      }

      window>box {
        margin-left: 5px;
        margin-right: 5px;
        margin-top: 5px;
        background-color: #3b4252;
      }

      #workspaces {
        padding-left: 0px;
        padding-right: 4px;
      }

      #workspaces button {
        padding-top: 5px;
        padding-bottom: 5px;
        padding-left: 6px;
        padding-right: 6px;
        color: #d8dee9;
      }

      #workspaces button.focused {
        background-color: rgb(181, 232, 224);
        color: rgb(26, 24, 38);
      }

      #workspaces button.urgent {
        color: rgb(26, 24, 38);
      }

      #workspaces button:hover {
        background-color: #b38dac;
        color: rgb(26, 24, 38);
      }

      tooltip {
        /* background: rgb(250, 244, 252); */
        background: #3b4253;
      }

      tooltip label {
        color: #e4e8ef;
      }

      #custom-launcher {
        font-size: 20px;
        padding-left: 8px;
        padding-right: 6px;
        color: #7ebae4;
      }

      #mode,
      #clock,
      #memory,
      #temperature,
      #cpu,
      #mpd,
      #custom-wall,
      #temperature,
      #backlight,
      #pulseaudio,
      #network,
      #battery,
      #custom-powermenu,
      #custom-cava-internal {
        padding-left: 10px;
        padding-right: 10px;
      }

      /* #mode { */
      /* 	margin-left: 10px; */
      /* 	background-color: rgb(248, 189, 150); */
      /*     color: rgb(26, 24, 38); */
      /* } */
      #memory {
        color: #8ebbba;
      }

      #cpu {
        color: #b38dac;
      }

      #clock {
        color: #e4e8ef;
      }

      #custom-wall {
        color: #b38dac;
      }

      #temperature {
        color: #80a0c0;
      }

      #backlight {
        color: #a2bd8b;
      }

      #pulseaudio {
        color: #e9c98a;
      }

      #network {
        color: #99cc99;
      }

      #network.disconnected {
        color: #cccccc;
      }

      #battery.charging,
      #battery.full,
      #battery.discharging {
        color: #cf876f;
      }

      #battery.critical:not(.charging) {
        color: #d6dce7;
      }

      #custom-powermenu {
        color: #bd6069;
      }

      #tray {
        padding-right: 8px;
        padding-left: 10px;
      }

      #tray menu {
        background: #3b4252;
        color: #dee2ea;
      }

      #mpd.paused {
        color: rgb(192, 202, 245);
        font-style: italic;
      }

      #mpd.stopped {
        background: transparent;
      }

      #mpd {
        color: #e4e8ef;

        /* color: #c0caf5; */
      }

      #custom-cava-internal {
        font-family: "Maple Mono NF CN";
      }
    '';
    settings = [
      {
        layer = "top";
        position = "top";
        # start_hidden = false;
        modules-left = [
          "niri/workspaces"
          #"niri/window"
          "wlr/taskbar"
          "temperature"
          "mpd"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "network"
          "battery"
        ];
        "niri/workspaces" = {
          # "format" = "{icon}";
          # "on-click" = "activate";
          # "disable-scroll" = true;
        };
        "wlr/taskbar" = {
          icon-size = 15;
          on-click = "activate";
          on-click-middle = "close";
        };
        "backlight" = {
          # "device" = "intel_backlight";
          # "on-scroll-up" = "light -A 5";
          "on-scroll-up" = "brightnessctl set +1%";
          # "on-scroll-down" = "light -U 5";
          "on-scroll-down" = "brightnessctl set 1%-";
          "format" = "{icon} {percent}%";
          "format-icons" = [
            "󰃝"
            "󰃞"
            "󰃟"
            "󰃠"
          ];
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          "tooltip-format" = "<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰍛 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰻠 {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          # "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "network" = {
          "interval" = 1;
          "format-wifi" = "󰖩 {essid} ({ipaddr})";
          "format-ethernet" = "󰀂 {ifname} ({ipaddr})";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-disconnected" = "󰯡 Disconnected";
          "tooltip" = false;
        };
        "temperature" = {
          #"critical-threshold"= 80;
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }
    ];
  };
}
