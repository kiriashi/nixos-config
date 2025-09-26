{ pkgs, ... }:
{
  home.packages = with pkgs; [
      exiftoo
      # search
      ripgrep

      # misc
      wlr-randr
      killall
      tree
      jaq
    ];
  programs = {
    yazi = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        manager = {
          layout = [
            1
            4
            3
          ];
          sort_by = "alphabetical";
          sort_sensitive = true;
          sort_reverse = false;
          sort_dir_first = true;
          linemode = "none";
          show_hidden = false;
          show_symlink = true;
        };
        preview = {
          tab_size = 2;
          max_width = 600;
          max_height = 900;
          cache_dir = config.xdg.cacheHome;
        };
      };
    };
    
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    btop = {
      enable = true;
      package = pkgs.btop.override { rocmSupport = true; };

      settings = {
        theme_background = false;
        update_ms = 500;
      };
    };

    imv = {
      enable = true;
    };

    fzf = {
      enable = true;

      enableFishIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'eza --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };

    eza.enable = true;

    mcfly = {
      enable = true;
      enableFishIntegration = true;
      fzf.enable = true;
    };
  };
}