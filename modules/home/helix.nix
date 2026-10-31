{ ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "dark_plus";

      editor = {
        scrolloff = 10;
        mouse = false;
        shell = [
          "fish"
          "-c"
        ];
        line-number = "relative";
        continue-comments = false;
        gutters = [
          "diagnostics"
          "line-numbers"
          "diff"
        ];
        idle-timeout = 200;
        completion-timeout = 200;
        text-width = 140;
        default-line-ending = "lf";
        end-of-line-diagnostics = "hint";

        statusline = {
          left = [
            "mode"
            "spinner"
            "workspace-diagnostics"
            "diagnostics"
          ];
          center = [
            "file-name"
            "read-only-indicator"
            "separator"
            "total-line-numbers"
            "position-percentage"
          ];
          right = [ "file-modification-indicator" ];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
          diagnostics = [
            "warning"
            "error"
          ];
          workspace-diagnostics = [
            "warning"
            "error"
          ];
        };

        lsp.display-inlay-hints = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        auto-save = {
          focus-lost = true;
          after-delay.enable = true;
        };

        whitespace = {
          render.tab = "all";
          characters = {
            tab = "→";
            tabpad = "·";
          };
        };

        indent-guides = {
          render = true;
          character = "┆";
        };

        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "error";
        };
      };

      keys =
        let
          wordKeys = {
            "C-home" = "goto_file_start";
            "C-end" = "goto_file_end";
            "C-left" = "move_prev_word_start";
            "C-right" = "move_next_word_start";
          };
        in
        {
          normal = wordKeys // {
            "C-backspace" = "delete_word_backward";
            "C-del" = "delete_word_forward";

            "C-w" = {
              "S-left" = "swap_view_left";
              "S-down" = "swap_view_down";
              "S-up" = "swap_view_up";
              "S-right" = "swap_view_right";
            };
          };

          insert = wordKeys;
          select = wordKeys;
        };
    };

    languages = {
      language-server = {
        rust-analyzer.config = {
          check.command = "clippy";
          cargo.features = "all";
        };

        clangd = {
          command = "clangd";
          args = [
            "--background-index"
            "--clang-tidy"
            "--completion-style=detailed"
          ];
        };

        nixd = {
          command = "nixd";
          config.nixd = {
            nixpkgs.expr = ''import (builtins.getFlake "/home/felix/.config/nixos/").inputs.nixpkgs { }'';
            options = {
              nixos.expr = ''(builtins.getFlake "/home/felix/.config/nixos/").nixosConfigurations.Workstation-Server.options'';
              home-manager.expr = ''(builtins.getFlake "/home/felix/.config/nixos/").homeConfigurations."felix@Workstation-Server".options'';
            };
          };
        };

        ty = {
          command = "ty";
          args = [ "server" ];
        };

        ruff = {
          command = "ruff";
          args = [ "server" ];
        };

        biome = {
          command = "biome";
          args = [ "lsp-proxy" ];
        };

        tombi = {
          command = "tombi";
          args = [ "lsp" ];
        };

        rumdl = {
          command = "rumdl";
          args = [ "server" ];
        };
      };

      language =
        let
          biomeFormatter = {
            command = "biome";
            args = [
              "format"
              "--stdin-file-path"
              "%{buffer_name}"
            ];
          };
        in
        [
          {
            name = "rust";
            auto-format = true;
          }
          {
            name = "c";
            auto-format = true;
            language-servers = [ "clangd" ];
          }
          {
            name = "nix";
            auto-format = true;
            language-servers = [ "nixd" ];
            formatter.command = "nixfmt";
          }
          {
            name = "python";
            auto-format = true;
            language-servers = [
              "ty"
              {
                name = "ruff";
                only-features = [
                  "diagnostics"
                  "code-action"
                ];
              }
            ];
            formatter = {
              command = "bash";
              args = [
                "-o"
                "pipefail"
                "-c"
                "ruff check --select I --fix-only --stdin-filename '%{buffer_name}' - | ruff format --stdin-filename '%{buffer_name}' -"
              ];
            };
          }
          {
            name = "json";
            auto-format = true;
            language-servers = [
              "vscode-json-language-server"
              "biome"
            ];
            formatter = biomeFormatter;
          }
          {
            name = "jsonc";
            auto-format = true;
            language-servers = [
              "vscode-json-language-server"
              "biome"
            ];
            formatter = biomeFormatter;
          }
          {
            name = "yaml";
            auto-format = true;
            language-servers = [ "yaml-language-server" ];
            formatter = {
              command = "yamlfmt";
              args = [ "-in" ];
            };
          }
          {
            name = "toml";
            auto-format = true;
            language-servers = [ "tombi" ];
          }
          {
            name = "markdown";
            auto-format = true;
            soft-wrap.enable = true;
            language-servers = [ "rumdl" ];
            formatter = {
              command = "rumdl";
              args = [
                "fmt"
                "--silent"
                "-"
              ];
            };
          }
        ];
    };
  };
}
