{ lib, pkgs }:
{
  language = [
    {
      name = "nix";
      formatter = {
        command = "${lib.getExe pkgs.nixfmt-rfc-style}";
      };
    }
    {
      name = "typescript";
      auto-format = true;
      language-servers = [
        # "dprint"
        "typescript-language-server"
      ];
    }
  ];

  language-server = {
    deno-lsp = {
      command = lib.getExe pkgs.deno;
      args = [ "lsp" ];
      environment.NO_COLOR = "1";
      config.deno = {
        enable = true;
        lint = true;
        unstable = true;
        suggest = {
          completeFunctionCalls = false;
          imports = {
            hosts."https://deno.land" = true;
          };
        };
        inlayHints = {
          enumMemberValues.enabled = true;
          functionLikeReturnTypes.enabled = true;
          parameterNames.enabled = "all";
          parameterTypes.enabled = true;
          propertyDeclarationTypes.enabled = true;
          variableTypes.enabled = true;
        };
      };
    };

    typescript-language-server = {
      command = lib.getExe pkgs.nodePackages.typescript-language-server;
      args = [ "--stdio" ];
      # config = {
      #   typescript-language-server.source = {
      #     addMissingImports.ts = true;
      #     fixAll.ts = true;
      #     organizeImports.ts = true;
      #     removeUnusedImports.ts = true;
      #     sortImports.ts = true;
      #   };
      # };
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
}
