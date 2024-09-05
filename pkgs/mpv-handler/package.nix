{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "mpv-handler";
  version = "0.3.12";

  src = fetchFromGitHub {
    owner = "akiirui";
    repo = "mpv-handler";
    rev = "v${version}";
    hash = "sha256-K+1yF3QrItn2HEnQYayAc48Qp2lPSKzwqCKX1MiSvnk=";
  };

  cargoHash = "sha256-BqE1c9vLf9Oi1Htq2tVp8pLeSFEkYkMRw4P8/6elv8k=";

  postInstall = ''
    install -Dm444 -t $out/share/applications share/linux/mpv-handler.desktop
  '';

  meta = {
    description = "A protocol handler for mpv. Use mpv and yt-dlp to play video and music from the websites";
    homepage = "https://github.com/akiirui/mpv-handler";
    license = lib.licenses.mit;
    mainProgram = "mpv-handler";
  };
}
