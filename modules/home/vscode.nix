{ pkgs, ... }:
let
  rgPath = "${pkgs.ripgrep}/bin/rg";

  commonSettings = {
    "git.autofetch" = true;
    "git.confirmSync" = false;
    "diffEditor.codeLens" = true;

    "security.workspace.trust.enabled" = false;
    "files.autoSave" = "afterDelay";
    "editor.formatOnSave" = true;
    "files.trimTrailingWhitespace" = true;
    "files.insertFinalNewline" = true;

    "todo-tree.ripgrep.ripgrep" = rgPath;

    "workbench.colorTheme" = "Dark+";
    "workbench.iconTheme" = "vs-seti";
    "workbench.activityBar.location" = "top";
    "editor.minimap.autohide" = "mouseover";

    "kilo-code.new.attention.enabled" = true;
  };

  commonExtensions = with pkgs.vscode-extensions; [
    streetsidesoftware.code-spell-checker
    tamasfe.even-better-toml
    kilocode.kilo-code
    github.vscode-pull-request-github
    davidanson.vscode-markdownlint
    gruntfuggly.todo-tree
  ];
in
{
  programs.vscode = {
    enable = true;

    profiles = {
      default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;

        extensions =
          commonExtensions
          ++ (with pkgs.vscode-extensions; [
            esbenp.prettier-vscode
            tomoki1207.pdf
            #spadin.zmk-tools
          ]);

        userSettings = commonSettings // {
          "window.newWindowProfile" = "Default";
          "editor.defaultFormatter" = "esbenp.prettier-vscode";

          "[markdown]" = {
            "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
          };
          "[toml]" = {
            "editor.defaultFormatter" = "tamasfe.even-better-toml";
          };
          "telemetry.telemetryLevel" = "off";
          "kilo-code.new.agentWorkStyle" = "human-in-the-loop";
        };
      };

      APA = {
        extensions =
          commonExtensions
          ++ (with pkgs.vscode-extensions; [
            vadimcn.vscode-lldb
            #connor4312.esbuild-problem-matchers
            dbaeumer.vscode-eslint
            #ms-vscode.extension-test-runner
            christian-kohler.npm-intellisense
            esbenp.prettier-vscode
            yoavbls.pretty-ts-errors
            rust-lang.rust-analyzer
          ]);

        userSettings = commonSettings // {
          "[markdown]" = {
            "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
          };
          "[toml]" = {
            "editor.defaultFormatter" = "tamasfe.even-better-toml";
          };
        };
      };

      FLL = {
        extensions =
          commonExtensions
          ++ (with pkgs.vscode-extensions; [
            ms-python.python
            ms-python.vscode-pylance
            ms-python.debugpy
            ms-python.vscode-python-envs
            charliermarsh.ruff
          ]);

        userSettings = commonSettings;
      };
    };
  };
}
