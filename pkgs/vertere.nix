{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook4,
  gtk4,
  gtk4-layer-shell,
  glib,
  cairo,
  pango,
  gdk-pixbuf,
  graphene,
  wayland,
  grim,
  slurp,
  wl-clipboard,
}:

rustPlatform.buildRustPackage rec {
  pname = "vertere";
  version = "0.1.0-unstable-2026-07-25";

  src = fetchFromGitHub {
    owner = "ocfox";
    repo = "vertere";
    rev = "2bbbd3c535c79398c7090e3caac86f13e5ad306f";
    hash = "sha256-TJWsXGEgktU5y2UhnDyBTEwMvbA3n9jI/I6gs4ZWyR4=";
  };

  cargoHash = "sha256-qkQIT92R1rK9s1yECepfGEk8imy1UtHfs+4OfdFl7jU=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    gtk4
    gtk4-layer-shell
    glib
    cairo
    pango
    gdk-pixbuf
    graphene
    wayland
  ];

  postInstall = ''
    mkdir -p $out/share
    cp -r data/applications data/icons -t $out/share/
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --prefix PATH : ${
        lib.makeBinPath [
          grim
          slurp
          wl-clipboard
        ]
      }
    )
  '';

  meta = {
    description = "Wayland translator";
    homepage = "https://github.com/ocfox/vertere";
    license = lib.licenses.mit;
    mainProgram = "vertere";
    platforms = lib.platforms.linux;
  };
}
