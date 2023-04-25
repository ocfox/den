{ lib, pkgs }:
{
  door = pkgs.fetchurl {
    url = "https://pastb.in/door.jpg";
    name = "door.jpg";
    hash = "sha256-4Gf2IvehQ9JXD1kzgYRNFZZi17UWx++09tU05U7Q7To=";
  };

  cowboyBebop = {
    op = pkgs.fetchurl {
      url = "https://pastb.in/cowboybebop-op.jpg";
      name = "cowboybebop-op.jpg";
      hash = "sha256-Re6bEdMwQae+E2JNq/5Ah+9iuaJIgFHxg8UqJ36itA8=";
    };

    sky = pkgs.fetchurl {
      url = "https://pastb.in/cowboybebop-sky.jpg";
      name = "cowboybebop-sky.jpg";
      hash = "sha256-2fhkMXkNCvkmuA7yTOzTa/3AQxgu2QsSKGqHAxOB7K4=";
    };

    bebop = pkgs.fetchurl {
      url = "https://pastb.in/cowboybebop-bebop.jpg";
      name = "cowboybebop-bebop.jpg";
      hash = "sha256-nWw1gnXq526ykBl31or5DBYUVDmEshqs5Jz2mQlKSMQ=";
    };
  };
}
