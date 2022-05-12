{
  config,
  pkgs,
  ...
}: {
  environment.sessionVariables = rec {
    CARGO_HOME = "\${HOME}/.cargo";
    CARGO_BIN = "\${HOME}/.cargo/bin";

    # enable fcitx5/ibus input method for kitty
    GLFW_IM_MODULE = "ibus";

    PATH = [
      "\${CARGO_BIN}"
      "\${CARGO_HOME}"
    ];
  };
}
