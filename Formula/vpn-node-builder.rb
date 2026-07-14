class VpnNodeBuilder < Formula
  desc "MyCS VPN node builder CLI (Docker-hosted)"
  homepage "https://github.com/novassist-ai/mycs-node"
  license "GPL-3.0-or-later"
  head "https://github.com/novassist-ai/mycs-node.git", branch: "dev"

  depends_on "docker" => :run

  def install
    launcher = "apps/clients/vpn-node-builder/scripts/vpnb-docker"
    odie "vpn-node-builder must be built from the mycs-node repository checkout" unless buildpath.join(launcher).exist?

    # Same script; basename selects channel (vpnb → :latest, vpnb-dev → :dev).
    bin.install launcher => "vpnb"
    bin.install_symlink "vpnb" => "vpnb-dev"
  end

  def caveats
    <<~EOS
      Commands:
        vpnb       → ghcr.io/novassist-ai/vpn-node-builder:latest  (prod)
        vpnb-dev   → ghcr.io/novassist-ai/vpn-node-builder:dev     (dev tip)

      Pull before first use (or after image updates):

        vpnb pull
        vpnb-dev pull

      Override either channel with VPNB_IMAGE or VPN_NODE_BUILDER_IMAGE, e.g.:

        export VPNB_IMAGE=ghcr.io/novassist-ai/vpn-node-builder:0.0.3
    EOS
  end

  test do
    assert_predicate bin/"vpnb", :exist?
    assert_predicate bin/"vpnb-dev", :exist?
    assert_match "ghcr.io/novassist-ai/vpn-node-builder",
                 File.read(bin/"vpnb")
  end
end
