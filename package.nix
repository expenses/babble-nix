{ stdenv, cmake, ninja, libclang, libllvm }:
stdenv.mkDerivation {
  name = "babble";

  # good source filtering is important for caching of builds.
  # It's easier when subprojects have their own distinct subfolders.
  src = fetchGit {
    url = "https://github.com/expenses/babble";
    rev = "a31b4c465f70dd073a22aee8621ebae69ca53e04";
    ref = "nix-test";
    submodules = true;
  };

  cmakeFlags = [
    "-DLIBCLANG_DIR=${libclang.lib}"
  ];

  # Distinguishing between native build inputs (runnable on the host
  # at compile time) and normal build inputs (runnable on target
  # platform at run time) is important for cross compilation.
  nativeBuildInputs = [ cmake ninja ];
  buildInputs = [ libclang libllvm ];

}
