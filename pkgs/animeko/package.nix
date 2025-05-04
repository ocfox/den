{
  fetchurl,
  appimageTools,
  vlc,
}:

let
  version = "4.10.1";

  appimage = fetchurl {
    url = "https://github.com/open-ani/animeko/releases/download/v${version}/ani-${version}-linux-x86_64.appimage";
    sha256 = "sha256-ShxLBek10j3Q5sViH7N02MRLutPOCSBdO/RYfi8rCt0=";
  };
in

appimageTools.wrapType2 {
  pname = "animeko";
  inherit version;
  src = appimage;

  extraPkgs = pkgs: [
    vlc
  ];
}
