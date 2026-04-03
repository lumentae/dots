final: prev: {
  jetbrains = prev.jetbrains // {
    clion = prev.jetbrains.clion.overrideAttrs (old: {
      version = "2026.1";
      src = prev.fetchurl {
        url = "https://download-cdn.jetbrains.com/cpp/CLion-2026.1.tar.gz";
        hash = "sha256-0790kj32lpfhj59hppm9cmqp3g1ck1jp1ndfy842js5sddiyb5xg";
      };
    });
  };
}
