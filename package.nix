{ stdenv, cmake, ninja, libclang, libllvm }:
stdenv.mkDerivation {
  name = "babble";

  # good source filtering is important for caching of builds.
  # It's easier when subprojects have their own distinct subfolders.
  src = fetchGit {
    url = "https://github.com/expenses/babble";
    rev = "25c81be9f9af7b8c2b0fd24a06bc2570a0a01573";
    ref = "nix-test";
    submodules = true;
  };

  cmakeFlags = [
    "-DBBL_CLANG_INCLUDE_DIR=${libclang.lib}/lib/clang/16/include"
  ];

  # Distinguishing between native build inputs (runnable on the host
  # at compile time) and normal build inputs (runnable on target
  # platform at run time) is important for cross compilation.
  nativeBuildInputs = [ cmake ninja ];
  buildInputs = [ libclang libllvm ];

}
