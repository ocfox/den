{ config
, pkgs
, ...
}: {
  environment = {
    sessionVariables = rec {
      CARGO_HOME = "\${HOME}/.cargo";
      CARGO_BIN = "\${HOME}/.cargo/bin";

      GLFW_IM_MODULE = "ibus";

      PATH = [
        "\${CARGO_BIN}"
        "\${CARGO_HOME}"
      ];
    };
  };
}
