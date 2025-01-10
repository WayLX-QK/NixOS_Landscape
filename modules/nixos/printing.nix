{ config, pkgs, ... }: {
  # Enable CUPS for printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      brlaser
      brgenml1lpr
      brgenml1cupswrapper
      cups-brother-hl2260d
    ];
  };

  # Enable Avahi for network printer discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
