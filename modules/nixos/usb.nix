{ pkgs, ... }:

{
  # USB Automounting
  services.gvfs.enable = true;
  # services.udisks2.enable = true;
  # services.devmon.enable = true;

  # Enable USB Guard
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    # FIXME: set yours pref USB devices (change {id} to your trusted USB device), use `lsusb` command (from usbutils package) to get list of all connected USB devices including integrated devices like camera, bluetooth, wifi, etc. with their IDs or just disable `usbguard`
    rules = ''
      allow id 3535:2000 # device 1
      allow id 174c:55aa # device 2
      allow id 8087:0029 # Bluetooth
      allow id 2b7e:b663 # SunplusIT Inc HD Webcam
      allow id 05e3:0620 # Genesys Logic, Inc. GL3523 Hub
      allow id 05e3:0610 # Genesys Logic, Inc. Hub
      allow id 3554:f58e # Compx VXE Mouse 1K Dongle
    '';
  };

  # Enable USB-specific packages
  environment.systemPackages = with pkgs; [
    usbutils
  ];
}
