{
  flake.modules.homeManager.editor =
    { lib, pkgs, ... }:
    {
      home.packages = with pkgs; [
        nil
        biome
      ];
      programs.helix = {
        enable = true;
        defaultEditor = true;
        settings = {
          theme = "everforest_dark";
          editor = {
            line-number = "relative";
            mouse = false;
          };
          editor.cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          keys = {
            normal = {
              "esc" = "collapse_selection";
              "H" = "goto_line_start";
              "L" = "goto_line_end";
              "+" = ":format";
              space = {
                backspace = ":w";
                q = ":q";
              };
            };
            select = {
              "H" = "goto_line_start";
              "L" = "goto_line_end";
            };
          };
        };
        languages = {
          language = [
            {
              name = "nix";
              formatter = {
                command = "${lib.getExe pkgs.nixfmt-rfc-style}";
              };
            }
            {
              name = "typescript";
              language-id = "typescript";
              scope = "source.ts";
              injection-regex = "^(ts|typescript)$";
              file-types = [ "ts" ];
              shebangs = [
                "deno"
                "node"
              ];
              roots = [
                "deno.json"
                "deno.jsonc"
                "package.json"
                "tsconfig.json"
              ];
              auto-format = true;
              language-servers = [
                {
                  name = "deno-lsp";
                  except-features = [
                    "format"
                  ];
                }
                {
                  name = "typescript-language-server";
                  except-features = [
                    "format"
                  ];
                }
                "biome"
              ];
              formatter = {
                command = "biome";
                args = [
                  "format"
                  "--stdin-file-path"
                  "a.ts"
                ];
              };
            }
          ];

          language-server = {
            deno-lsp = {
              command = lib.getExe pkgs.deno;
              args = [ "lsp" ];
              required-root-patterns = [ "deno.*" ];
              config.deno = {
                enable = true;
                suggest = {
                  completeFunctionCalls = false;
                  imports = {
                    hosts = {
                      "https://deno.land" = true;
                    };
                  };
                };
              };
            };

            typescript-language-server = {
              command = lib.getExe pkgs.nodePackages.typescript-language-server;
              args = [ "--stdio" ];
              required-root-patterns = [
                "package.json"
                "tsconfig.json"
              ];
            };

            vscode-css-language-server = {
              command = "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-css-language-server";
              args = [ "--stdio" ];
              config = {
                provideFormatter = true;
                css.validate.enable = true;
                scss.validate.enable = true;
              };
            };

            ruff = {
              command = lib.getExe pkgs.ruff;
              args = [ "server" ];
            };

            dprint = {
              command = lib.getExe pkgs.dprint;
              args = [ "lsp" ];
            };

            vscode-json-language-server = {
              command = lib.getExe pkgs.vscode-json-languageserver;
              args = [ "--stdio" ];
            };
          };
        };
      };
    };
}
