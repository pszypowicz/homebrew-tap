class TmuxPersonal < Formula
  desc "Tmux fork with trackpad gesture reporting (DEC 2035)"
  homepage "https://github.com/pszypowicz/tmux"
  url "https://github.com/pszypowicz/tmux/archive/refs/tags/v3.8-personal.1.tar.gz"
  version "3.8-personal.1"
  sha256 "2afaf4997d7b475425826e931a912159dd1f7fb8836eced620b5741d24687347"
  license "ISC"

  # Decodes gesture escape sequences emitted by the ghostty-personal
  # build into bindable keys (Swipe2Left, PinchIn, SmartMagnify, ...);
  # see PROTOCOL-GESTURES.md in the source tree. Versioning follows the
  # tap convention <upstream-anchor>-personal.<N> against the upstream
  # next-3.8 development version. tmux -V reports next-3.8; the tap
  # version is authoritative for upgrades.
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "pkg-config" => :build
  depends_on "libevent"
  depends_on "ncurses"
  depends_on "utf8proc"

  conflicts_with "tmux", because: "both install a tmux binary"

  def install
    system "sh", "autogen.sh"
    system "./configure", "--enable-utf8proc",
                          "--disable-jemalloc",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make", "install"
  end

  test do
    socket = "test#{Process.pid}"
    system bin/"tmux", "-L", socket, "-f", File::NULL, "new-session", "-d", "sleep 5"
    system bin/"tmux", "-L", socket, "bind", "-n", "Swipe2Left", "next-window"
    assert_match "Swipe2Left", shell_output("#{bin}/tmux -L #{socket} list-keys -T root")
    system bin/"tmux", "-L", socket, "kill-server"
  end
end
