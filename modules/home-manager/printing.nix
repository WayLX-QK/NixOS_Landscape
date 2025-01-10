{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Add printing-related packages for the user
  home.packages = with pkgs; [
    system-config-printer  # GUI for managing printers
    cups                   # CUPS client tools
    foomatic-db            # Database for printer drivers
    #gutenprint             # Gutenprint driver support
  ];
}