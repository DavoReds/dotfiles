{
  lib,
  config,
  ...
}: {
  options.helix = {
    enable = lib.mkEnableOption "Installs and configures helix";
    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      description = "Make Helix the default editor";
      default = false;
    };
  };

  config = lib.mkIf config.helix.enable {
    # Custom theme
    xdg.configFile."helix/themes/catppuccin_mocha.toml" = {
      enable = true;
      text =
        /*
        toml
        */
        ''
          inherits = "catppuccin_mocha"

          "markup.heading.1" = { fg = "sapphire", modifiers = [ "bold" ]}
          "markup.bold" = { fg = "peach", modifiers = [ "bold" ] }
          "markup.italic" = { fg = "teal", modifiers = [ "italic" ] }
        '';
    };

    programs.helix = {
      enable = true;
      defaultEditor = config.helix.defaultEditor;

      settings = {
        theme = "catppuccin_mocha";

        editor = {
          auto-completion = true;
          auto-format = true;
          bufferline = "multiple";
          color-modes = true;
          completion-trigger-len = 1;
          cursorline = true;
          gutters = ["diagnostics" "spacer" "line-numbers" "spacer" "diff"];
          indent-heuristic = "tree-sitter";
          insert-final-newline = false;
          line-number = "relative";
          middle-click-paste = true;
          mouse = true;
          popup-border = "all";
          preview-completion-insert = false;
          rulers = [81];
          scrolloff = 8;
          text-width = 80;
          true-color = true;

          statusline = {
            left = [
              "mode"
              "spacer"
              "spinner"
              "spacer"
              "version-control"
            ];
            center = [
              "file-name"
              "file-type"
              "file-modification-indicator"
              "read-only-indicator"
            ];
            right = [
              "diagnostics"
              "workspace-diagnostics"
              "position"
              "total-line-numbers"
              "position-percentage"
              "spacer"
              "register"
            ];
          };

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          file-picker = {
            hidden = true;
          };

          auto-pairs = true;

          indent-guides = {
            render = true;
            character = "┆";
            skip-levels = 1;
          };

          lsp = {
            display-messages = true;
            display-signature-help-docs = true;
            display-inlay-hints = false;
            auto-signature-help = true;
            snippets = true;
          };

          smart-tab = {
            enable = false;
          };
        };

        keys.normal = {
          H = ":buffer-previous";
          L = ":buffer-next";

          space = {
            b.c = ":buffer-close!";
          };
        };

        keys.insert = {
          C-x = "completion";
          C-f = "move_parent_node_end";
        };
      };

      languages = {
        use-grammars = {
          only = [
            "c"
            "css"
            "docker-compose"
            "dockerfile"
            "git-attributes"
            "git-commit"
            "git-ignore"
            "git-rebase"
            "go"
            "gomod"
            "html"
            "javascript"
            "jinja"
            "jsdoc"
            "json"
            "json5"
            "jsonc"
            "jsx"
            "just"
            "lua"
            "markdown"
            "markdown.inline"
            "mermaid"
            "nix"
            "python"
            "ron"
            "rust"
            "sql"
            "templ"
            "toml"
            "tsx"
            "typescript"
            "typst"
            "xml"
            "yaml"
            "zig"
            "bash"
          ];
        };

        language-server = {
          pyright-langserver = {
            command = "pyright-langserver";
            args = ["--stdio"];
          };

          emmet-lsp = {
            command = "emmet-language-server";
            args = ["--stdio"];
          };

          vscode-html-language-server = {
            command = "vscode-html-language-server";
            args = ["--stdio"];
          };

          vscode-css-language-server = {
            command = "vscode-css-language-server";
            args = ["--stdio"];
          };

          templ = {
            command = "templ";
            args = ["lsp"];
          };

          htmx = {
            command = "htmx-lsp";
            args = [""];
          };

          tinymist = {
            command = "tinymist";
          };
        };

        language = [
          {
            name = "python";
            language-servers = ["pyright-langserver"];
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "py"];
            };
            auto-format = true;
          }

          {
            name = "rust";
            auto-format = true;
          }

          {
            name = "zig";
            auto-format = true;
          }

          {
            name = "c";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "clang-format";
              args = ["--style" "Chromium"];
            };
            auto-format = true;
          }

          {
            name = "javascript";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "js"];
            };
            auto-format = true;
          }

          {
            name = "typescript";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "ts"];
            };
            auto-format = true;
          }

          {
            name = "jsx";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "jsx"];
            };
            auto-format = true;
            auto-pairs = {
              "<" = ">";
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "'" = "'";
              "`" = "`";
            };
          }

          {
            name = "tsx";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "tsx"];
            };
            auto-format = true;
            auto-pairs = {
              "<" = ">";
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "'" = "'";
              "`" = "`";
            };
          }

          {
            name = "html";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            language-servers = [
              "emmet-lsp"
              "vscode-html-language-server"
              "htmx"
            ];
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "html"];
            };
            auto-format = true;
            auto-pairs = {
              "<" = ">";
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "'" = "'";
              "`" = "`";
            };
          }

          {
            name = "css";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            language-servers = [
              "emmet-lsp"
              "vscode-css-language-server"
            ];
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "css"];
            };
            auto-format = true;
            auto-pairs = {
              "<" = ">";
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "'" = "'";
              "`" = "`";
            };
          }

          {
            name = "json";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "json"];
            };
            auto-format = true;
          }

          {
            name = "go";
            auto-format = true;
          }

          {
            name = "markdown";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "md"];
            };
            auto-format = true;
            soft-wrap = {
              enable = true;
              wrap-indicator = "";
              wrap-at-text-width = true;
            };
            auto-pairs = {
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "'" = "'";
              "`" = "`";
              "_" = "_";
            };
          }

          {
            name = "toml";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "taplo";
              args = ["fmt" "-"];
            };
            auto-format = true;
            auto-pairs = {
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "'" = "'";
              "`" = "`";
              "$" = "$";
            };
          }

          {
            name = "lua";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "stylua";
              args = ["--indent-type" "Spaces" "-"];
            };
            auto-format = true;
          }

          {
            name = "sql";
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "sql"];
            };
            auto-format = true;
          }

          {
            name = "dockerfile";
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "./Dockerfile"];
            };
            auto-format = true;
          }

          {
            name = "yaml";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "yaml"];
            };
            auto-format = true;
          }

          {
            name = "templ";
            language-servers = [
              "templ"
              "emmet-lsp"
              "vscode-html-language-server"
              "htmx"
            ];
            formatter = {
              command = "templ";
              args = ["fmt"];
            };
            auto-format = true;
          }

          {
            name = "jinja";
            language-servers = [
              "emmet-lsp"
              "vscode-html-language-server"
              "htmx"
            ];
            formatter = {
              command = "dprint";
              args = ["fmt" "--stdin" "jinja"];
            };
            auto-format = true;
            auto-pairs = {
              "<" = ">";
              "(" = ")";
              "{" = "}";
              "[" = "]";
              "\"" = "\"";
              "'" = "'";
              "`" = "`";
            };
          }

          {
            name = "haskell";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            formatter = {
              command = "ormolu";
              args = ["-"];
            };
            auto-format = true;
          }

          {
            name = "nix";
            indent = {
              tab-width = 2;
              unit = " ";
            };
            formatter = {
              command = "alejandra";
              args = ["-"];
            };
            auto-format = true;
          }

          {
            name = "typst";
            indent = {
              tab-width = 2;
              unit = "  ";
            };
            language-servers = ["tinymist"];
            formatter = {
              command = "typstfmt";
              args = ["-o" "-"];
            };
            auto-format = true;
          }

          {
            name = "ocaml";
            formatter = {
              command = "ocamlformat";
              args = ["-" "--impl"];
            };
            auto-format = true;
          }
        ];
      };
    };
  };
}
