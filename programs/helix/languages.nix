{ pkgs }:
[
  {
    name = "nix";
    formatter = {
      command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
    };
  }
]
