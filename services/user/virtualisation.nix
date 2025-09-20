{
  pkgs,
  ...
}:

{
  # imports = [ ./pci-passthrough.nix ];
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
        virtiofsd
        virglrenderer

        virtualgl
        pkgsi686Linux.virtualgl
      ];
    };
  };

  programs.virt-manager.enable = true;

  users.users.kiriashi.extraGroups = [ "libvirtd" ];

  boot.extraModprobeConfig = "options kvm_amd nested=1";

  environment.systemPackages = with pkgs; [
    distrobox_git
    distroshelf
    pods

    virglrenderer
    virtualgl
    pkgsi686Linux.virtualgl
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

}
