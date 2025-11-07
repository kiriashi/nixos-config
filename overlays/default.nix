{ pkgs, selfPkgs, lib, ... }:
{
  nixpkgs.overlays = [ 
    (final: prev: { self = selfPkgs; }) 

    (import ./niri-checks.nix {})
    (import ./gtk-xdg-hacks.nix { inherit lib; })
    (import ./fcitx-qt-hacks.nix { inherit lib; })
    (final: prev: {
      podman = prev.podman.override { iptables = final.nftables; };
    })
  ];
}
