# This file defines overlays
{inputs, ...}: let
  electron-flags = [
    "--password-store=gnome-libsecret"
    "--enable-features=UseOzonePlatform"
    "--ozone-platform=wayland"
    "--enable-wayland-ime"
  ];
in rec {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    # temporary fix google-chrome dev tool crash
    # google-chrome = prev.google-chrome.override {
    #   commandLineArgs = electron-flags;
    # };
    vscode = prev.vscode.override {
      commandLineArgs = electron-flags;
    };

    # nautilus = prev.nautilus.overrideAttrs (nsuper: {
    #   buildInputs =
    #     nsuper.buildInputs
    #     ++ (with prev.gst_all_1; [
    #       gst-plugins-good
    #       gst-plugins-bad
    #     ]);
    # });
    # # fix hyprland switch workspace event error patch
    # ags = prev.ags.overrideAttrs (old: {
    #   src = prev.fetchFromGitHub {
    #     owner = "wenjinnn";
    #     repo = "ags";
    #     rev = "08043a95130f674b621370260bc153769e167d2e";
    #     hash = "sha256-8fhWCcixq0lR/AhZG/U8Kcw6UPOMxM571WiQ2demcoE=";
    #     fetchSubmodules = true;
    #   };
    #   buildInputs =
    #     old.buildInputs
    #     ++ (with prev.pkgs; [
    #       accountsservice
    #       gtk3
    #       libdbusmenu-gtk3
    #       gvfs
    #       libnotify
    #       pam
    #     ]);
    # });
    # # rename astal to ags greeter
    # ags-greeter = final.callPackage ./ags-greeter {};
    # # IM support patch
    # swappy = prev.swappy.overrideAttrs (old: {
    #   src = prev.fetchFromGitHub {
    #     owner = "jtheoof";
    #     repo = "swappy";
    #     rev = "fca4f6dcdb05c78ad63a0924412a4ef3345484a0";
    #     hash = "sha256-gwlUklfr/NA7JIkB9YloS9f8+3h5y3rSs3ISeVXAPZk=";
    #   };
    # });
    # # rss2email from main branch that support lmtp feature
    # rss2email = prev.rss2email.overrideAttrs (old: {
    #   src = prev.pkgs.fetchFromGitHub {
    #     owner = "rss2email";
    #     repo = "rss2email";
    #     rev = "0efe6c299b4e9f2545455d6bc6b6c2753cff1440";
    #     hash = "sha256-QuNRXtKDEx20On4dyCgJ6yGSI0WSxdwr/IuzD35JzVQ=";
    #   };
    #   patches = null;
    #   installCheckPhase = null;
    # });
  
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  # unstable-packages = final: _prev: {
  #   unstable = import inputs.nixpkgs-unstable {
  #     system = final.system;
  #     config.allowUnfree = true;
  #     overlays = [modifications];
  #   };
  # };
}
