{
  pkgs,
  ...
}:

{
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    bat
    tealdeer
    du-dust
    fd
    tokei
    duf
  ];

  programs.fish = {
    enable = true;
    shellAbbrs = {
      commit = "git commit --all";
      push = "git push";
      rebuild = "sudo nixos-rebuild switch --flake .#";
      rebuild-boot = "sudo nixos-rebuild boot --flake .#";
      update = "nix flake update && git commit -a -m 'update.' && sudo nixos-rebuild switch --flake .#";
      clean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      shutdown = "systemctl poweroff";
      reboot = "systemctl reboot";

      cat = "bat";
      du = "dust";
      find = "fd";
      df = "duf";
      cd = "z";

      nvim = "hx";
      vim = "hx";
      vi = "hx";
      helix = "hx";
    };
    interactiveShellInit = ''
      fastfetch
      set --global fish_greeting 日々私たちが過ごしている日常は、実は、奇跡の連続なのかもしれない。
    '';
    vendor = {
      functions.enable = true;
      config.enable = true;
      completions.enable = true;
    };
  };
}
