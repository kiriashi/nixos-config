{
  pkgs,
  ...
}:

{
  users.defaultUserShell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    fastfetch
    git
    wget
    bat
    busybox
    tealdeer
    du-dust
    dutree
    fd
    tokei
    duf
  ];

  programs.fish = {
    enable = true;
      shellAbbrs = {
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
    vendor = {
      functions.enable = true;
      config.enable = true;
      completions.enable = true;
    };
  };
}
