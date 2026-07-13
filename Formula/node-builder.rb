class NodeBuilder < Formula
  desc "MyCS VPN node builder CLI (Docker-hosted)"
  homepage "https://github.com/novassist-ai/mycs-node"
  license "GPL-3.0-or-later"
  head "https://github.com/novassist-ai/mycs-node.git", branch: "dev"

  depends_on "docker" => :run

  def install
    launcher = "apps/clients/node-builder/scripts/nb-docker"
    odie "node-builder must be built from the mycs-node repository checkout" unless buildpath.join(launcher).exist?

    # Same script; basename selects channel (nb → :latest, nb-dev → :dev).
    bin.install launcher => "nb"
    bin.install_symlink "nb" => "nb-dev"
  end

  def caveats
    <<~EOS
      Commands:
        nb       → ghcr.io/novassist-ai/node-builder:latest  (prod)
        nb-dev   → ghcr.io/novassist-ai/node-builder:dev     (dev tip)

      Pull before first use (or after image updates):

        nb pull
        nb-dev pull

      Override either channel with NB_IMAGE or NODE_BUILDER_IMAGE, e.g.:

        export NB_IMAGE=ghcr.io/novassist-ai/node-builder:0.0.3
    EOS
  end

  test do
    assert_predicate bin/"nb", :exist?
    assert_predicate bin/"nb-dev", :exist?
    assert_match "ghcr.io/novassist-ai/node-builder",
                 File.read(bin/"nb")
  end
end
