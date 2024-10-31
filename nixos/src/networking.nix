{
  ...
} : {
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 22 53 67 80 443 6667 1701 9001 4455 ];
      allowedUDPPorts = [ 22 53 67 80 443 6667 1701 9001 4455 5353 ];
      allowedTCPPortRanges = [
        { from = 3000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
  };
}
