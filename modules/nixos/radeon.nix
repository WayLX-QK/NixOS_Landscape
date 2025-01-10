{ config, lib, pkgs, ... }:

{

  # boot.kernelParams = [
  #   "amdgpu.ppfeaturemask=0xffffffff"
  # ];

  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
    # crashes gpu?!?!
    # amdvlk.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # extraPackages = with pkgs; [
    #   # amdvlk
    #   mesa
    #   #libva-vdpau-driver
    #   libvdpau-va-gl
    #   vulkan-tools
    #   vulkan-loader
    # ];
    # extraPackages32 = with pkgs.pkgsi686Linux; [
    #   # amdvlk
    #   mesa
    #   #libva-vdpau-driver
    #   libvdpau-va-gl
    # ];

  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  environment.systemPackages = with pkgs; [
    clinfo
    radeontop
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
  ];
}
