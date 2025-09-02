{
  stdenv,
  makeWrapper,
  unzip,
}:
stdenv.mkDerivation rec {
  pname = "class_widgets";
  version = "1.2.0.0";
  src = builtins.fetchurl {
    url = "https://github.com/Class-Widgets/Class-Widgets/releases/download/v1.2.0.1/ClassWidgets-Linux-x64.zip";
    sha256 = "1gigichygrjh83r077h44yl47cms76xqig2b4zr47qai9smg90gr";
  };
  unpackPhase = ''
    ${unzip}/bin/unzip ${src}
    mv ClassWidgets-Linux-x64/* .
    rm -r ClassWidgets-Linux-x64
  '';
  buildInputs = [ makeWrapper ];
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    mkdir -p $out/opt

    # 复制出客户端的 Javascript 部分，其它的不要了
    cp -r . $out/opt/class_widgets

    # 生成 bilibili 命令，运行这个命令时会调用 electron 加载客户端的 Javascript 包（$out/opt/app.asar）
    makeWrapper $out/opt/class_widgets/ClassWidgets $out/bin/class_widgets --prefix CLASSWIDGETS_NOT_PORTABLE : 1
    runHook postInstall
  '';
}
