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
        style_user = "blue";
        show_always = true;
      };

      # Replaced symbol - Nerd Font
      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };
      # Git status
      git_status = {
        deleted = " 󰍵 ";
        modified = "  ";
        staged = "  ";
        stashed = "  ";
      };

      nix_shell = {
        symbol = " ";  # Nix
        heuristic = true;
      };

      docker_context = {
        format = "[ $symbol ]($style)";
        symbol = "";  # Docker
        style = "bold blue";
        only_with_files = false;
      };

      golang = {
        format = "[ $symbol ]($style)";
        symbol = "";  # Go
        style = "bold blue";
      };
      
      java = {
        format = "[ $symbol ]($style)";
        symbol = "";  # Java
        style = "bold yellow";
      };

      lua = {
        format = "[ $symbol ]($style)";
        symbol = "";  # Lua
        style = "bold red";
      }; 

      nodejs = {
        format = "[ $symbol ]($style)";
        symbol = "";  # Node.js
        style = "bold green";
      };
      
      php = {
        format = "[ $symbol ]($style)";
        symbol = "";  # PHP
        style = "bold purple";
      }; 

      python = {
        format = "[ $symbol ]($style)";
        symbol = "";  # Python
        style = "bold blue";
      };
      
      ruby = {
        format = "[ $symbol ]($style)";
        symbol = "";  # Ruby
        style = "bold red";
      };
      
      rust = {
        format = "[ $symbol ]($style)";
        symbol = "";  # Rust
        style = "bold yellow";
      };
    };
  };
} 