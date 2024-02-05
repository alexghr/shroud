{
  nargo,
  stdenv
}:

{
  name,
  src,
  sha256,
}:
stdenv.mkDerivation {
  inherit name src;

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = sha256;

  buildInputs = [];

  buildPhase = ''
    runHook preBuild

    export HOME=$TMP/home
    export SRC=$TMP/src
    mkdir -p $HOME $SRC

    cp -r $src/* $SRC
    cd $SRC
    ${nargo}/bin/nargo compile

    cp target/${name}.json $out

    runHook postBuild
  '';
}
