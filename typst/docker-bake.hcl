group "default" {
  targets = [ "typst" ]
}

target "typst" {
  matrix = {
    item = [
      { typst = "0.13.1", typstyle = "0.13.0", variant = "1-bookworm" },
    ]
  }
  name = "typst-v${replace(item.typst, ".", "-")}"
  context = "./"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  args = {
    VARIANT = item.variant
    TYPST_VERSION = "v${item.typst}"
    TYPSTYLE_VERSION = "v${item.typstyle}"
  }
  tags = [
    "ghcr.io/cyanolupus/devcontainers/typst:${item.typst}",
  ]
  cache-from = [
    {
      type = "registry",
      ref = "ghcr.io/cyanolupus/devcontainers/typst:cache",
    }
  ]
  cache-to = [
    {
      type = "registry",
      ref = "ghcr.io/cyanolupus/devcontainers/typst:cache",
    }
  ]
}
