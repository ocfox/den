{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (pkgs.writeShellScriptBin "icalingua" ''
     #!/usr/bin/env bash
     icalingua-plus-plus --enable-features=UseOzonePlatform --ozone-platform=wayland
     '')

    (pkgs.writeShellScriptBin "spoti" ''
     #!/usr/bin/env bash
     spotify --enable-features=UseOzonePlatform --ozone-platform=wayland
     ''
     )
  ];
}
