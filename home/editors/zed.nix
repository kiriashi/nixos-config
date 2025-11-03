{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.optional.dev.zed
{
  home.packages = [ pkgs.nixd ];

  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;

    extensions = [
      "basher"
      "catppuccin-icons"
      "csharp"
      "codebook"
      "colorizer"
      "git-firefly"
      "html"
      "log"
      "java"
      "make"
      "neocmake"
      "nix"
      "scss"
      "sinppets"
    ];

    extraPackages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];

    userSettings = {
      active_pane_modifiers = {
        border_size = 2.0;
        inactive_opacity = 0.8;
      };

      collaboration_panel = {
        button = false;
      };

      file_types = {
        JSONC = [ "json" ];
      };

      git = {
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = true;
          delay_ms = 2000;
          show_commit_summary = true;
        };
      };

      git_panel = {
        button = true;
        dock = "left";
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
          formatter = {
            external = {
              command = lib.getExe pkgs.nixfmt-rfc-style;
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
        };
      };

      lsp = {
        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
            path_lookup = true;
          };
        };

        nix = {
          binary = {
            path_lookup = true;
          };
        };

        pylsp = {
          binary = {
            path = lib.getExe pkgs.python312Packages.python-lsp-server;
            path_lookup = true;
          };
        };
      };

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      outline_panel = {
        button = true;
      };

      tabs = {
        file_icons = true;
        git_status = true;
        show_diagnostics = "errors";
      };

      preview_tabs = {
        enabled = true;
        enable_preview_from_file_finder = true;
        enable_preview_from_code_navigation = true;
      };

      project_panel = {
        dock = "left";
        git_status = true;
        indent_size = 23;
        indent_guides = {
          show = "always";
        };
        scrollbar = {
          show = "auto";
        };
      };

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      terminal = {
        env = {
          EDITOR = "zeditor --wait";
        };
        shell = "system";
      };

      auto_update = false;
      autosave = "on_focus_change";
      base_keymap = "VSCode";
      buffer_font_weight = 400.0;
      buffer_font_size = lib.mkForce 14;
      current_line_highlight = "all";
      disable_ai = true;
      format_on_save = "on";
      icon_theme = "Catppuccin Frappé";
      lsp_highlight_debounce = 75;
      restore_on_startup = "last_session";
      ui_font_weight = 500.0;
      ui_font_size = lib.mkForce 15;
      unnecessary_code_fade = 0.7;
      vim_mode = false;
    };
  };
}
