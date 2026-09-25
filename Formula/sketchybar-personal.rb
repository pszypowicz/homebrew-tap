class SketchybarPersonal < Formula
  desc "SketchyBar fork with per-display topmost and fullscreen visibility"
  homepage "https://github.com/pszypowicz/SketchyBar"
  url "https://github.com/pszypowicz/SketchyBar/archive/refs/tags/v2.24.1-personal.1.tar.gz"
  version "2.24.1-personal.1"
  sha256 "c622a22ec1920e81e36ada4f565685dfbddcb590506e3ba4bda40e421f88d329"
  license "GPL-3.0-only"

  # Built from the personal branch of the fork, which carries the patches
  # listed in the release notes on top of upstream master. Versioning follows
  # the tap convention <upstream-anchor>-personal.<N>. sketchybar --version
  # reports the upstream version, so the tap version is the one to compare.
  # The binary keeps the upstream name, so configs and plugins that call
  # sketchybar work unchanged. It clashes with felixkratz/formulae/sketchybar
  # on bin/sketchybar, and brew link reports that. A conflicts_with on a
  # formula in another tap would make Homebrew load it, which fails unless
  # that tap is trusted.

  def install
    # The makefile sets its own flags and builds a universal binary.
    ENV.delete("CFLAGS")
    ENV.delete("LDFLAGS")
    ENV.delete("CXXFLAGS")
    (var/"log/sketchybar").mkpath
    system "make"
    system "codesign", "--force", "-s", "-", "bin/sketchybar"
    bin.install "bin/sketchybar"
    (pkgshare/"examples").install "sketchybarrc"
    (pkgshare/"examples").install "plugins"
  end

  service do
    run opt_bin/"sketchybar"
    environment_variables PATH: std_service_path_env, LANG: "en_US.UTF-8"
    keep_alive true
    process_type :interactive
    log_path var/"log/sketchybar/sketchybar.out.log"
    error_log_path var/"log/sketchybar/sketchybar.err.log"
  end

  test do
    assert_match "sketchybar-v", shell_output("#{bin}/sketchybar --version")
  end
end
