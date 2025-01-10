{config, ...}: {
  services.git-sync = {
    enable = true;
    repositories.archive = {
      path = config.home.sessionVariables.ARCHIVE;
      uri = "git@github.com:WayLX-QK/archive.git";
    };
  };
}
