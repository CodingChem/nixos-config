{ config, pkgs, ... }:

let
  # 1. Definer flaggene du fant på GitHub
  waylandJavaFlags = "-Dawt.toolkit.name=WLToolkit -Dsun.java2d.vulkan=true -Dsun.java2d.vulkan.accelsd=true";

  # 2. En hjelpefunksjon som "wrapper" programmet med flaggene
  # Den tar inn en pakke (pkg) og navnet på den kjørbare filen (binName)
  patchWayland = pkg: binName: pkg.overrideAttrs (oldAttrs: {
    # Vi må ha 'makeWrapper' verktøyet tilgjengelig under byggingen
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
    
    # Etter at pakken er installert, pakker vi den inn med nye flagg
    postFixup = (oldAttrs.postFixup or "") + ''
      wrapProgram $out/bin/${binName} \
        --add-flags "${waylandJavaFlags}"
    '';
  });
in
{
  environment.systemPackages = with pkgs; [
    # 3. Bruk funksjonen på pakkene
    
    # For Android Studio (binæren heter vanligvis 'android-studio')
    (patchWayland android-studio-full "android-studio")

    # For IntelliJ. NB: Sjekk om du bruker idea-community eller idea-ultimate
    # Binæren heter vanligvis 'idea-community' eller 'idea-ultimate'
    (patchWayland jetbrains.idea-community "idea-community")
  ];
}
