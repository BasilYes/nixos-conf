{ config
, pkgs
, extraOptions
, ...
}:

let
  ip = "${pkgs.iproute2}/bin/ip";
  iptables = "${pkgs.iptables}/bin/iptables";
in
{

  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.forwarding" = 1;
  # };

  environment.etc = {
    wgnetns.source = ./scripts/wgnetns.sh;
    setup_proxy.source = ./scripts/setup_proxy.sh;
  };

  systemd.services."netnswg" = {
    description = "wg network namespace";
    before = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${ip} netns add wg";
      ExecStop = "${ip} netns del wg";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # systemd.services."netnswg-setup" = {
  #   description = "Set up veth for netns";
  #   after = [ "netnswg.service" "wireguard-wg0.service" "network.target" ];
  #   wants = [ "netnswg.service" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     ExecStart = ''
  #       ${ip} link add veth0 type veth peer name veth1
  #       ${ip} addr add 192.168.100.1/24 dev veth0
  #       ${ip} link set veth0 up
  #       ${ip} link set veth1 netns wg
  #       ${ip} netns exec wg ${ip} addr add 192.168.100.2/24 dev veth1
  #       ${ip} netns exec wg ${ip} link set veth1 up
  #       ${ip} netns exec wg ${iptables} -t nat -A POSTROUTING -o wg0 -j MASQUERADE
  #       ${iptables} -t nat -A PREROUTING -p tcp --dport 8888 -j DNAT --to-destination 192.168.100.2:8888
  #     '';
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };

  systemd.services.wireguard-wg0 = {
    bindsTo = [ "netnswg.service" ];
    after = [ "netnswg.service" ];
  };
  networking.wireguard.interfaces = {
    wg0 = {
      mtu = 1332;
      privateKeyFile = "/etc/keys/wg-key";
      ips = [ "10.8.0.28/24" ];
      interfaceNamespace = "wg";
      peers = [
        {
          publicKey = "FWdikn2GySVfIy9ujij9HH4QSjlvZkHpVYpaqgCFlis=";
          presharedKeyFile = "/etc/keys/wg-presharkey";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          persistentKeepalive = 25;
          endpoint = "147.45.197.172:35419";
        }
      ];
    };
  };

  services.tinyproxy = {
    enable = true;
    settings = {
      Allow = "0.0.0.0/0";
      Listen = "0.0.0.0";
      Port = 8888;
    };
  };
  systemd.services.tinyproxy = {
    bindsTo = [ "wireguard-wg0.service" ];
    after = [ "wireguard-wg0.service" ];
    serviceConfig.NetworkNamespacePath = "/run/netns/wg";
  };

  #   wg = "${pkgs.wireguard-tools}/bin/wg";
  #   wgConfig = "/etc/keys/wg0.conf";
  #   ipv4Addr = "10.8.0.28/24";
  #   # ipv6Addr = "fd00::2/64";     # Укажите свой IPv6

  # systemd.services."netns@" = {
  #   description = "%I network namespace";
  #   before = [ "network.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     ExecStart = "${ip} netns add %I";
  #     ExecStop = "${ip} netns del %I";
  #   };
  # };
  # systemd.services.wg = {
  #   description = "WireGuard network interface";
  #   bindsTo = [ "netns@wg.service" ];
  #   requires = [ "network-online.target" ];
  #   after = [ "netns@wg.service" "network-online.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     RemainAfterExit = true;
  #     ExecStart = pkgs.writers.writeBash "wg-up" ''
  #       set -e
  #       ${ip} link add wg0 type wireguard
  #       ${ip} link set wg0 netns wg
  #       ${ip} -n wg address add ${ipv4Addr} dev wg0
  #       # $ip} -n wg -6 address add $ipv6Addr} dev wg0
  #       ${ip} netns exec wg ${wg} setconf wg0 ${wgConfig}
  #       ${ip} -n wg link set wg0 up
  #       ${ip} -n wg route add default dev wg0
  #       ${ip} -n wg -6 route add default dev wg0
  #     '';
  #     ExecStop = pkgs.writers.writeBash "wg-down" ''
  #       ${ip} -n wg route del default dev wg0 || true
  #       ${ip} -n wg -6 route del default dev wg0 || true
  #       ${ip} -n wg link del wg0 || true
  #     '';
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };

  security.sudo.extraRules = [
    {
      users = [ extraOptions.userName ];
      commands = [
        {
          command = "/etc/setup_proxy";
          options = [ "NOPASSWD" ];
        }
      ];
    }
    {
      users = [ extraOptions.userName ];
      commands = [
        {
          command = "/etc/wgnetns";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
