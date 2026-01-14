{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.dmenu.overrideAttrs (_: {
      src = ./../src/dmenu;
      patches = [ ];
    }))
    (pkgs.st.overrideAttrs (_: {
      src = ./../src/st;
      patches = [ ];
    }))
    slock
  ];
}
