final: prev: {
  jetbrains = prev.jetbrains // {
    clion = prev.jetbrains.clion.overrideAttrs (old: {
      version = "2026.1";
      src = prev.fetchurl {
        url = "https://download-cdn.jetbrains.com/cpp/CLion-2026.1.tar.gz";
        hash = "sha256-r5flY2u6aCkI8q7ZcGWYLLxxcWWp3gtTkdBdKoacIB0=";
      };
      buildInputs = (old.buildInputs or []) ++ [
        prev.openssl_1_1
      ];
    });
  };
}