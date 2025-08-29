{
  stdenv,
  makeWrapper,
  unzip,
}:
stdenv.mkDerivation rec {
  pname = "class_widgets";
  version = "1.2.0.0";
  src = builtins.fetchurl {
    url = "https://github.com/Class-Widgets/Class-Widgets/releases/download/v20250828-nightly/Linux-x64_debug-17301270705.zip";
    sha256 = "105hc7g38v2apw0nrshpcl5cbzhmpljm4nd6b8526jc2f1lg1420";
  };
  unpackPhase = ''
    ${unzip}/bin/unzip ${src}
    mv Linux-x64_debug-17301270705/* .
    rm -r Linux-x64_debug-17301270705
  '';
  buildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt

    # 复制出客户端的 Javascript 部分，其它的不要了
    cp -r . $out/opt/class_widgets

    # 生成 bilibili 命令，运行这个命令时会调用 electron 加载客户端的 Javascript 包（$out/opt/app.asar）
    makeWrapper $out/opt/class_widgets/ClassWidgets $out/bin/class_widgets --prefix CLASSWIDGETS_NOT_PORTABLE : 1
  '';
}
