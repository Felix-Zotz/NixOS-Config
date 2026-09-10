{...}: {
  programs.firefox = {
    enable = true;

    policies = {
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;

      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        # SponsorBlock
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };

        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
        };

        # KeePassXC
        "keepassxc-browser@keepassxc.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      isDefault = true;

      settings = {
        "browser.translations.enable" = false;
        "browser.translations.automaticallyPopup" = false;
        "browser.toolbars.bookmarks.visibility" = "always";
      };

      bookmarks = {
        force = true;
        settings = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "AI";
                bookmarks = [
                  {
                    name = "Open WebUI";
                    url = "http://192.168.178.176:8080";
                  }
                  {
                    name = "Gemini";
                    url = "https://gemini.google.com/app";
                  }
                  {
                    name = "Claude";
                    url = "https://claude.ai";
                  }
                  {
                    name = "ChatGPT";
                    url = "https://chatgpt.com";
                  }
                  {
                    name = "OpenRouter";
                    url = "https://openrouter.ai";
                  }
                ];
              }
              {
                name = "FLL";
                toolbar = true;
                bookmarks = [
                  {
                    name = "Nextcloud";
                    url = "https://nextcloud.qantumtech.de";
                  }
                  {
                    name = "Pybricks";
                    url = "https://docs.pybricks.com";
                  }
                  {
                    name = "Gemini";
                    url = "https://gemini.google.com/notebook/2693b78e-6400-4c37-836f-90ac0d7abf95";
                  }
                  {
                    name = "GitHub";
                    url = "https://github.com/Felix-Zotz/Robotics_Rutesheim";
                  }
                  {
                    name = "Website";
                    url = "https://robotics-rutesheim.netlify.app";
                  }
                ];
              }
              {
                name = "Github";
                url = "https://github.com";
              }
              {
                name = "Type Practicing";
                url = "https://www.keybr.com";
              }
              {
                name = "DeepL";
                url = "https://www.deepl.com";
              }
              {
                name = "Gmail";
                url = "https://mail.google.com";
              }
            ];
          }
        ];
      };
    };
  };
}
