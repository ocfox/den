{ config, pkgs, ... }:
{

  environment.sessionVariables = rec {
    CARGO_HOME = "\${HOME}/.cargo";
    CARGO_BIN = "\${HOME}/.cargo/bin";

    PATH = [
      "\${CARGO_BIN}"
      "\${CARGO_HOME}"
    ];
  };
}
