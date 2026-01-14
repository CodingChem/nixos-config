{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.dmenu.overrideAttrs (_: {
      src = ./dmenu;
      patches = [ ];
    }))
    (pkgs.st.overrideAttrs (_: {
      src = ./st;
      patches = [ ];
    }]]
    slock
    surf
  ];
}
