{ ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # Custom format
      format = ''
        $all$username$character
      ''; 

      # Username
      username = {
        format = "[$user]($style) ";
        style_user = "bold blue";
        show_always = true;
      };

      # Replaced symbol - Nerd Font
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      # Git status
      git_status = {
        deleted = "󰍵";
        modified = "";
        staged = "";
        stashed = "";
      };

      # nix-shell
      nix_shell = {
        symbol = " ";
        heuristic = true;
      };
    };
  };
} 