# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs, ...}: {
  # example = pkgs.callPackage ./example { };

  fhs = pkgs.callPackage ./fhs {};

  # wemeet = pkgs.callPackage ./wemeet {};

  # yt6801 = pkgs.callPackage ./yt6801 {};
}
