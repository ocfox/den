{ ... }: {
  nixpkgs.overlays = [
    (self: super: {
      factorio = super.factorio.override {
        username = "ocfox";
        token = "483926ff66c4429ec6084fc0533c17";
      };

      waybar = super.waybar.overrideAttrs (old: {
        patchPhase = ''
          sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        '';
        mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
