{ self, inputs, ... }: {

  perSystem = { pkgs, lib, ... }:
    let
      inherit (pkgs) hugo mkShell stdenv;
      inherit (inputs) papermod;
    in
    {
      devShells.blog = mkShell {
        packages = [ hugo ];

        env = {
          HUGO_MODULE_IMPORTS_PATH = "${papermod}";
        };
      };

      packages.blog = stdenv.mkDerivation {
        pname = "blog";
        version = lib.substring 0 8 self.lastModifiedDate;

        src = "${self}/blog";
        nativeBuildInputs = [ hugo ];
        env = {
          HUGO_MODULE_IMPORTS_PATH = "${papermod}";
          HUGO_PUBLISHDIR = placeholder "out";
        };

        buildPhase = "hugo";
      };
    };
}
