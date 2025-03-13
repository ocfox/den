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

  metallica = {
    default = pkgs.fetchurl {
      url = "https://pastb.in/metallica.jpg";
      name = "metallica.jpg";
      hash = "sha256-W2zCjwU6DQR4rYKVwN1OKV54VUW58+awwemz4JAlCgQ=";
    };
    and-justice-for-all = pkgs.fetchurl {
      url = "https://pastb.in/and-justice-for-all.jpg";
      name = "and-justice-for-all.jpg";
      hash = "sha256-lkst81OfaYHnvfY/KRRZpqC0mjTGRdk0WBdkeDqI9JM=";
    };
  };
}
