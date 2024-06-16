{ lib, pkgs }:
{
  door = pkgs.fetchurl {
    url = "https://pastb.in/door.jpg";
    name = "door.jpg";
    hash = "sha256-4Gf2IvehQ9JXD1kzgYRNFZZi17UWx++09tU05U7Q7To=";
  };

  cowboyBebop = {
    default = pkgs.fetchurl {
      url = "https://transfer.ocfox.me/A5/cowboy_bebop.jpg";
      name = "cowboyBebop.jpg";
      hash = "sha256-5ECftbBSl2lG5FWLs9+2QTL3T0a3xY+y4ufnh9ceHl4=";
    };

    op = pkgs.fetchurl {
      url = "https://pastb.in/cowboybebop-op.jpg";
      name = "cowboybebop-op.jpg";
      hash = "sha256-Re6bEdMwQae+E2JNq/5Ah+9iuaJIgFHxg8UqJ36itA8=";
    };

    bebop = pkgs.fetchurl {
      url = "https://pastb.in/cowboybebop-bebop.jpg";
      name = "cowboybebop-bebop.jpg";
      hash = "sha256-nWw1gnXq526ykBl31or5DBYUVDmEshqs5Jz2mQlKSMQ=";
    };
  };
}
