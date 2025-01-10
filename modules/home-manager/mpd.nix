{pkgs, ...}: {
  home.packages = [
    pkgs.mpc
  ];
  services = {
    mpd-mpris.enable = true;
    mpd = {
      enable = true;
      musicDirectory = "~/Music";
      extraConfig = ''
        audio_output {
          type  "pipewire"
          name  "PipeWire Sound Server"
        }
      '';
    };
  };
  programs.ncmpcpp = {
    enable = true;
    bindings = [
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "J";
        command = ["select_item" "scroll_down"];
      }
      {
        key = "K";
        command = ["select_item" "scroll_up"];
      }
    ];
    settings = {
      lyrics_directory = "~/Music/.lyrics";
      mpd_host = "localhost";
      mpd_port = 6600;
      mpd_connection_timeout = 5;
      # mpd_music_dir = "~/Music";
      mpd_crossfade_time = 5;
      startup_screen = "media_library";
      external_editor = "nvim";
      use_console_editor = "yes";
    };
  };
}
