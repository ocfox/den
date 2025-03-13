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
      file-types = [
        "ts"
        "tsx"
      ];
      language-servers = [ "deno-language-server" ];
    }
  ];

  language-server.deno-language-server = {
    command = "${lib.getExe pkgs.deno}";
    args = [ "lsp" ];
    required-root-patterns = [
      "deno.json"
    ];
  };
}
