{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "smartdns-rs";
  version = "0.8.7";

  src = fetchFromGitHub {
    owner = "mokeyish";
    repo = "smartdns-rs";
    rev = "refs/tags/v${version}";
    hash = "sha256-YvuwvEQLL3KTRvK7BAmUJGqPE1WdiDfleWXf3VL7IX0=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "async-socks5-0.6.0" = "sha256-jbVwQW43vRMFsejwS6F9fcpAWTcKiTYFWM0/0o7s6/g=";
      "hickory-proto-0.25.0-alpha.1" = "sha256-rCiCcn1SvB3ToOqQ7AdnVRxIEUu/xlpQV5CPklZ8Ktc=";
      "hostname-0.3.1" = "sha256-LwQSgLIq/xqlmaSqWyoNkjzwOZH0de5tvLdZ3riokmU=";
    };
  };

  nativeBuildInputs = [
    rustPlatform.bindgenHook
  ];

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.IOKit
    darwin.apple_sdk.frameworks.Security
  ];

  checkFlags = [
    # need network
    "--skip=dns_client::tests::test_nameserver_alidns_resolve"
    "--skip=dns_client::tests::test_nameserver_cloudflare_resolve"
    "--skip=dns_client::tests::test_nameserver_h3_resolve"
    "--skip=dns_client::tests::test_nameserver_https_resolve"
    "--skip=dns_client::tests::test_nameserver_quic_over_proxy_resolve"
    "--skip=dns_client::tests::test_nameserver_quic_resolve"
    "--skip=dns_client::tests::test_nameserver_tls_resolve"
    "--skip=dns_client::tests::test_with_default"
    "--skip=dns_mw_cache::tests::test_lookup_serde"
    "--skip=dns_mw_ns::tests::test_edns_client_subnet"
    "--skip=infra::os_release::tests::is_target_os"
    "--skip=infra::ping::tests::test_ping_fatest"
    "--skip=infra::ping::tests::test_ping_https"
    "--skip=infra::ping::tests::test_ping_simple"
  ];

  meta = {
    description = "Cross platform local DNS server (Dnsmasq like) written in rust";
    homepage = "https://github.com/mokeyish/smartdns-rs";
    license = lib.licenses.gpl3Only;
    mainProgram = "smartdns";
  };
}
