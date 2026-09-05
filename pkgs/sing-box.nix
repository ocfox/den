{
  fetchFromGitHub,
  sing-box,
}:

sing-box.overrideAttrs (oldAttrs: rec {
  version = "1.15.0-alpha.1";

  src = fetchFromGitHub {
    owner = "SagerNet";
    repo = "sing-box";
    tag = "v${version}";
    hash = "sha256-Qrb8+9DZZvVjdvDj01vmbNw+3N5aMGB2q+WV9+t5fAw=";
  };

  vendorHash = "sha256-6r7CBc0Er0zlaTOuyOY8qN6yjUNjBKJz0UjhD9aQaxY=";
})
