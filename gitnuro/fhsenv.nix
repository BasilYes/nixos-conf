{ buildFHSEnv
, gitnuro-unwrapped
, extraPkgs ? pkgs: [ ]
}:

buildFHSEnv {
  name = "gitnuro";

  runScript = "gitnuro";
  
  targetPkgs = pkgs: with pkgs; [
    gitnuro-unwrapped
    gnome.zenity
  ] ++ extraPkgs pkgs;
  
  extraInstallCommands = ''
    mkdir -p $out/share
    ln -sf ${gitnuro-unwrapped}/share/applications $out/share
    ln -sf ${gitnuro-unwrapped}/share/icons $out/share
  '';
  
  meta = gitnuro-unwrapped.meta;
}
