class VpnNodeBuilder < Formula
  desc "MyCS VPN node builder CLI (Docker-hosted)"
  homepage "https://github.com/novassist-ai/mycs-node"
  url "https://github.com/novassist-ai/mycs-node/archive/refs/tags/vpnb_0.6.0.tar.gz"
  sha256 "d78b173a0860052e2a8c45135b70c6538b4e585cfd1bbd3230d7d2f2fd6b88fc"
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
    # Embed formula version so `vpnb --version` reports the Homebrew install.
    inreplace bin/"vpnb",
              'VPNB_LAUNCHER_VERSION="${VPNB_LAUNCHER_VERSION:-}"',
              "VPNB_LAUNCHER_VERSION=\"#{version}\""
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
        vpnb --version    # Homebrew formula + docker image versions

      Override either channel with VPNB_IMAGE or VPN_NODE_BUILDER_IMAGE, e.g.:

        export VPNB_IMAGE=ghcr.io/novassist-ai/vpn-node-builder:0.6.0

      Tip builds of the launcher script: brew install --HEAD vpn-node-builder
    EOS
  end

  test do
    assert_path_exists bin/"vpnb"
    assert_path_exists bin/"vpnb-dev"
    assert_match "ghcr.io/novassist-ai/vpn-node-builder",
                 File.read(bin/"vpnb")
    assert_match(/VPNB_LAUNCHER_VERSION="#{version}"/, File.read(bin/"vpnb"))
  end
end
