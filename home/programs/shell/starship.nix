{ ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = ''
        $all$username$character
      ''; 

      localip = {
        ssh_only = false;
        format = "📟 [$localipv4](bold red) ";
        disabled = true;
      };

      hostname = {
        ssh_only = false;
        format = "on [$hostname](bold yellow) ";
        trim_at = ".";
        disabled = true;
      };

      username = {
        format = "[$user]($style) ";
        style_user = "blue bold";
        style_root = "red bold";
        show_always = true;
        disabled = false;
      };

      character = {
        success_symbol = "[›](bold green)";
        error_symbol = "[›](bold red)";
      };

      nix_shell = {
        symbol = " ";
        heuristic = true;
      };

      directory = {
        read_only = " ";
        truncation_length = 10;
        truncate_to_repo = true;
        style = "bold italic blue";
      };

      git_branch = { symbol = " "; };
      hg_branch = { symbol = " "; };
      aws = { symbol = " "; };      
      package = { symbol = "󰏗 "; };
      shlvl = { symbol = " "; };  

      git_status = {
        deleted = " 󰍵 ";
        modified = "  ";
        staged = "  ";
        stashed = "  ";
        ahead = " ⬆ ";
        behind  = " ⬇ ";
        diverged = " ↹ ";
      };

      docker_context = {
        format = "[$symbol]($style)";
        symbol = " ";
        style = "bold blue";
        only_with_files = true;
        detect_files = [ 
          "podman-compose.yml" 
          "podman-compose.yaml" 
          "docker-compose.yml" 
          "docker-compose.yaml" 
          "Podmanfile" 
          "Dockerfile" 
        ];
        detect_folders = [ ];
        disabled = false;
      };

      nodejs = {
        format = "[$symbol $version ]($style)";
        symbol = "";
        style = "bold green";
        detect_files = [ "package.json" ".node-version" ];
        detect_folders = [ "node_modules" ];
      };

      python = {
        format = "[$symbol $version ]($style)";
        style = "bold yellow";
        symbol = "";
        pyenv_prefix = "venv ";
        python_binary = [ "./venv/bin/python" "python" "python3" "python2" ];
        detect_extensions = [ "py" ];
      };

      golang = {
        format = "[$symbol $version ]($style)";
        symbol = "";
        style = "bold blue";
      };
      
      java = {
        format = "[$symbol $version ]($style)";
        symbol = "";
        style = "bold yellow";
      };

      lua = {
        format = "[$symbol $version ]($style)";
        symbol = "";
        style = "bold red";
      }; 
      
      php = {
        format = "[$symbol $version ]($style)";
        symbol = "";
        style = "bold blue";
      }; 

      ruby = {
        format = "[$symbol $version ]($style)";
        symbol = ""; 
        style = "bold red";
      };
      
      rust = {
        format = "[$symbol $version ]($style)";
        symbol = "";  
        style = "bold yellow";
      };
    };
  };
} 