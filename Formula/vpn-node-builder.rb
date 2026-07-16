class VpnNodeBuilder < Formula
  desc "MyCS VPN node builder CLI (Docker-hosted)"
  homepage "https://github.com/novassist-ai/mycs-node"
  url "https://github.com/novassist-ai/mycs-node/archive/refs/tags/vpnb_0.3.0.tar.gz"
  sha256 "b6e9779cc31ad72cf17ab7fbf355a7fc85e271636feeb60576b332bb878f799b"
  license "GPL-3.0-or-later"
  head "https://github.com/novassist-ai/mycs-node.git", branch: "dev"

  depends_on "docker"

  def install
    launcher = "apps/clients/vpn-node-builder/scripts/vpnb-docker"
    unless buildpath.join(launcher).exist?
      odie "vpn-node-builder must be built from the mycs-node repository checkout"
    end

    # Same script; basename selects channel (vpnb → :latest, vpnb-dev → :dev).
    bin.install launcher => "vpnb"
    bin.install_symlink "vpnb" => "vpnb-dev"
  end

  def caveats
    <<~EOS
      Commands:
        vpnb       → ghcr.io/novassist-ai/vpn-node-builder:latest  (prod)
        vpnb-dev   → ghcr.io/novassist-ai/vpn-node-builder:dev     (dev tip)

      The launcher auto-pulls the image when missing. Host helpers:

        vpnb-dev update   # delete local :dev image and re-pull
        vpnb update       # delete local :latest image and re-pull
        vpnb-dev pull     # docker pull without deleting first

      Override either channel with VPNB_IMAGE or VPN_NODE_BUILDER_IMAGE, e.g.:

        export VPNB_IMAGE=ghcr.io/novassist-ai/vpn-node-builder:0.3.0

      Tip builds of the launcher script: brew install --HEAD vpn-node-builder
    EOS
  end

  test do
    assert_path_exists bin/"vpnb"
    assert_path_exists bin/"vpnb-dev"
    assert_match "ghcr.io/novassist-ai/vpn-node-builder",
                 File.read(bin/"vpnb")
  end
end
