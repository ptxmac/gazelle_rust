load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# go dependencies
load("//:go_deps.bzl", "go_dependencies")

# rust dependencies
load("//3rdparty/crates:crates.bzl", "crate_repositories")

# build crate_universe
load("@rules_rust//crate_universe:repositories.bzl", "crate_universe_dependencies")

# versions of dependencies
load(":deps_versions.bzl", "GAZELLE_SHA256", "GAZELLE_VERSION")

def gazelle_rust_dependencies1():
    # go/gazelle
    maybe(
        http_archive,
        name = "io_bazel_rules_go",
        sha256 = "685052b498b6ddfe562ca7a97736741d87916fe536623afb7da2824c0211c369",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.33.0/rules_go-v0.33.0.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.33.0/rules_go-v0.33.0.zip",
        ],
    )

    maybe(
        http_archive,
        name = "bazel_gazelle",
        patches = ["@gazelle_rust//patches:bazel-gazelle.patch"],
        sha256 = GAZELLE_SHA256,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v{0}/bazel-gazelle-v{0}.tar.gz".format(GAZELLE_VERSION),
            "https://github.com/bazelbuild/bazel-gazelle/releases/download/v{0}/bazel-gazelle-v{0}.tar.gz".format(GAZELLE_VERSION),
        ],
    )

    # protobuf
    maybe(
        http_archive,
        name = "rules_proto",
        sha256 = "e017528fd1c91c5a33f15493e3a398181a9e821a804eb7ff5acdd1d2d6c2b18d",
        strip_prefix = "rules_proto-4.0.0-3.20.0",
        urls = [
            "https://github.com/bazelbuild/rules_proto/archive/refs/tags/4.0.0-3.20.0.tar.gz",
        ],
    )

    # go dependencies
    go_dependencies()

    # rust dependencies
    crate_repositories()

    # build crate universe
    crate_universe_dependencies()
