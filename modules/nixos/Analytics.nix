{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
