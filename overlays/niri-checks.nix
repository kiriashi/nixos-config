{ ... }:
final: prev: {
  niri-stable = prev.niri-stable.overrideAttrs (_: { doCheck = false; });
  niri-unstable = prev.niri-unstable.overrideAttrs (_: { doCheck = false; });
  xwayland-satellite-stable = prev.xwayland-satellite-stable.overrideAttrs (_: { doCheck = false; });
  xwayland-satellite-unstable = prev.xwayland-satellite-unstable.overrideAttrs (_: { doCheck = false; });
}
