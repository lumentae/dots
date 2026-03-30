final: prev: {
  jetbrains = prev.jetbrains // {
    idea = prev.jetbrains.idea.overrideAttrs (old: {
      version = "2026.1";
      src = prev.fetchurl {
        url = "https://download.jetbrains.com/idea/ideaIU-2026.1.tar.gz";
        hash = "sha256-9X09uplwx3TPN3WDYprqVAQY5nfsY2VXDnbeqcsvP5s=";
      };
    });
  };
}
