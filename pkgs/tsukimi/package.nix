{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  wrapGAppsHook4,
  mpv,
  clapper,
  cairo,
  epoxy,
  gdk-pixbuf,
  glib,
  gst_all_1,
  gtk4,
  libadwaita,
  openssl,
  pango,
  xz,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "tsukimi";
  version = "0.12.2";

  src = fetchFromGitHub {
    owner = "tsukinaha";
    repo = "tsukimi";
    rev = "v${version}";
    hash = "sha256-pJ+SUNGQS/kqBdOg21GgDeZThcjnB0FhgG00qLfqxYA=";
  };

  cargoHash = "sha256-PCJiSyfEgK8inzoRmRvnAU50kLnyVhNrgLrwtBUFpIU=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs =
    [
      cairo
      clapper
      clapper.buildInputs
      epoxy
      gdk-pixbuf
      glib
      gst_all_1.gstreamer
      gtk4
      mpv
      libadwaita
      openssl
      pango
      xz
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ];

  doCheck = false;

  postInstall = ''
    mkdir -p $out/share/glib-2.0/schemas

    cp moe.tsuna.tsukimi.gschema.xml $out/share/glib-2.0/schemas/moe.tsuna.tsukimi.gschema.xml    
    glib-compile-schemas $out/share/glib-2.0/schemas/
  '';

  meta = {
    description = "A simple third-party Emby client";
    homepage = "https://github.com/tsukinaha/tsukimi";
    license = lib.licenses.gpl3Only;
    mainProgram = "tsukimi";
  };
}
