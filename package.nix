{ stdenv, cmake, ninja, libclang, libllvm }:
stdenv.mkDerivation {
  name = "babble";

  # good source filtering is important for caching of builds.
  # It's easier when subprojects have their own distinct subfolders.
  src = fetchGit {
    url = "https://github.com/expenses/babble";
    rev = "0e89dc6cdc89fc5f2b3a3ec6375b2a842ab287a5";
    ref = "nix-test";
    submodules = true;
  };

  # Distinguishing between native build inputs (runnable on the host
  # at compile time) and normal build inputs (runnable on target
  # platform at run time) is important for cross compilation.
  nativeBuildInputs = [ cmake ninja ];
  buildInputs = [ libclang libllvm ];

}
