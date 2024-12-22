{ stdenv , lib , fetchurl , appimageTools , makeWrapper , electron }:

stdenv.mkDerivation rec {
  pname = "super-productivity";
  version = "11.0.3";

  src = fetchurl {
    url = "https://github.com/johannesjo/super-productivity/releases/download/v${version}/superProductivity-x86_64.AppImage";
    hash = "sha256-jNh87r2mTiFg46IdnbuByknt66hxWV2tdyjR465upYo=";
    name = "${pname}-${version}.AppImage";
  };

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/${pname} $out/share/applications

    cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
    cp -a ${appimageContents}/superproductivity.desktop $out/share/applications/${pname}.desktop
    cp -a ${appimageContents}/usr/share/icons $out/share

    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname} --ozone-platform-hint=auto --disable-gpu-compositing'

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags $out/share/${pname}/resources/app.asar
  '';

  meta = {
    description = "To Do List / Time Tracker with Jira Integration";
    homepage = "https://super-productivity.com";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ offline ];
    mainProgram = "super-productivity";
    sourceProvenance = with lib.sourceTypes;[ binaryNativeCode ];
  };
}
