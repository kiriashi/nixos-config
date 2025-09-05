# 自定义软件包，可以与 nixpkgs 中的定义方式相同
# 你可以使用 'nix build .#example' 构建它们
pkgs: {
  # example = pkgs.callPackage ./example { };
}
