{ ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
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
        format = "[$symbol]($style) ";
        symbol = " ";
        heuristic = true;
      };

      # Python
      python = {
        format = "[$symbol $version]($style) ";
        symbol = "";
      };
      # Node.js
      nodejs = {
        format = "[$symbol $version]($style) ";
        symbol = "";
      };
      # Rust
      rust = {
        format = "[$symbol $version]($style) ";
        symbol = "";
      };
      # Go
      golang = {
        format = "[$symbol $version]($style) ";
        symbol = "";
      };
      # Java
      java = {
        format = "[$symbol $version]($style) ";
        symbol = "";
      };
      # Lua
      lua = {
        format = "[$symbol $version]($style) ";
        symbol = "";
      };
      # Ruby
      ruby = {
        format = "[$symbol $version]($style) ";
        symbol = "";
      };
      # PHP
      php = {
        format = "[$symbol $version]($style) ";
        symbol = "";
      };
      # Docker/Podman
      container = {
        format = "[$symbol]($style) ";
        symbol = "";
        # style = "bold white";
        # style_map = {
        #   docker = "bold blue";
        #   podman = "bold purple";
        # };
        symbol_map = {
          docker = "";
          podman = "󰡨";
        };
      };
    };
  };
}
