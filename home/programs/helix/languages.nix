{ lib, pkgs }:
{
  language = [
    {
      name = "nix";
      formatter = {
        command = "${lib.getExe pkgs.nixfmt-rfc-style}";
      };
    }
  ];
}
