self: super: {
  obs-studio = super.obs-studio.overrideAttrs (old: {
    cmakeFlags = (old.cmakeFlags or []) ++ [
      "-DENABLE_AMF=ON"
    ];
  });
}