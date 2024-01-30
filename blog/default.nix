{ self, inputs, ... }: {

  perSystem = { pkgs, lib, ... }:
    let
      inherit (pkgs) hugo mkShell stdenv;
      inherit (inputs) papermod;
      inherit (lib) substring;
    in
    {
      devShells.default = mkShell {
        packages = [
          hugo
        ];

        env = {
          HUGO_MODULE_IMPORTS_PATH = "${papermod}";
        };
      };

      packages.default = stdenv.mkDerivation {
        pname = "blog";
        version = substring 0 8 self.lastModifiedDate or self.lastModified or "19700101";

        src = self;
        nativeBuildInputs = [ hugo ];
        env = {
          HUGO_MODULE_IMPORTS_PATH = "${papermod}";
          HUGO_PUBLISHDIR = placeholder "out";
        };

        buildPhase = ''
          hugo
        '';
      };
    };
}
