{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#cad3f5";
        separator_color= "#cad3f5";
        font = "JetBrains Mono Regular 11";
        corner_radius = 10;
        notification_limit = 8;
        gap_size = 7;
        frame_width = 2;
        height = 100;
        width = 300;
        offset = "5x5";
        origin = "top-right";
        transparency = 10;
      };
      urgency_low = {
        background = "#24273A";
        foreground = "#CAD3F5";
      };
      urgency_normal = {
        background = "#24273A";
        foreground = "#CAD3F5";
      };
      urgency_critical = {
        background = "#24273A";
        foreground = "#CAD3F5";
        frame_color = "#F5A97F";
      };
    };
  };
}
