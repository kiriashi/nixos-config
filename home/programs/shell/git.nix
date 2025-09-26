{ config, ... }:
{
  programs = {
    git = {
      inherit (config.profile) userName userEmail;
      enable = true;

      lfs.enable = true;
      extraConfig = {
        credential.helper = "store";
        init.defaultBranch = "main";
        pull = {
          rebase = false;
        };
        feature = {
          manyFiles = true;
        };
        index = {
          skipHash = false;
        };
      };
    };

    lazygit = {
      enable = true;

      settings = {
        theme.nerdFontsVersion = 3;
        update.method = false;
        disableStartupPopups = true;
      };
    };
  };
}