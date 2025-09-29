{
  ppkgs,
  ...
}:

{ 
  programs = {
    eza = {
      enable = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
    };

    fish = {
      enable = true;
      shellAbbrs = {
        commit = "git commit --all";
        staged = "git add . && git commit --all";
        push = "git push";

        rebuild = "nh os switch . --ask";
        rebuildb = "nh os boot . --ask";
        rebuildc = "nh os switch . && nh clean all && nh os switch .";

        update = "nvfetcher --config ./pkgs/nvfetcher.toml && nix flake update && git commit -a -m 'update.' && nh os boot . --ask";
        sopsei =  "sops --encrypt --in-place";
        shutdown = "systemctl poweroff";
        reboot = "systemctl reboot";

        cat = "bat";
        du = "dust";
        find = "fd";
        df = "duf";
        cd = "z";
        nf = "nvfetcher";

        nvim = "hx";
        vim = "hx";
        vi = "hx";
        helix = "hx";
      };
      interactiveShellInit = ''
        fastfetch
        set --global fish_greeting 日々私たちが過ごしている日常は、実は、奇跡の連続なのかもしれない。
        set -gx PATH $HOME/.cargo/bin $PATH
      '';

      shellInit = ''
        if test -f "$HOME/.conda/bin/conda"
          eval $HOME/.conda/bin/conda "shell.fish" "hook" $argv | source
        end
      '';
    };
  };
}
