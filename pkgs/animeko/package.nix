{
  fetchurl,
  appimageTools,
  vlc,
}:

let
  version = "4.9.0";

  appimage = fetchurl {
    url = "https://github.com/open-ani/animeko/releases/download/v${version}/ani-${version}-linux-x86_64.appimage";
    sha256 = "sha256-5WWHBnl/uFzT6W9Cx12MO0obj8PhYfffNwHH5lIMgcg=";
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
