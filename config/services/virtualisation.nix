{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.optional.vir 
{
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          pkgs.OVMFFull.fd
        ];
      };
      vhostUserPackages = with pkgs; [
        virtio-win
        virtiofsd
        virglrenderer

        virtualgl
        pkgsi686Linux.virtualgl
      ];
    };
  };

  programs.virt-manager.enable = true;

  users.users.${config.profile.userName}.extraGroups = [ "libvirtd" ];

  boot.extraModprobeConfig = "options kvm_amd nested=1";

  environment.systemPackages = with pkgs; [
    distrobox_git
    distroshelf
    pods
    podman-compose
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };
}

