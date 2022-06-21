{
  config,
  pkgs,
  ...
}: {
  environment = {
    sessionVariables = rec {
      CARGO_HOME = "\${HOME}/.cargo";
      CARGO_BIN = "\${HOME}/.cargo/bin";

      # enable fcitx5/ibus input method for kitty
      GLFW_IM_MODULE = "ibus";

      PATH = [
        "\${CARGO_BIN}"
        "\${CARGO_HOME}"
      ];
    };

    variables = {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    };
  };
}
