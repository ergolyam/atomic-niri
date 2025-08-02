# atomic-niri   [![bluebuild build badge](https://github.com/ergolyam/atomic-niri/actions/workflows/atomic-publish.yml/badge.svg)](https://github.com/ergolyam/atomic-niri/actions/workflows/atomic-publish.yml)
`atomic-niri` is a custom [Fedora Atomic](https://universal-blue.org/) image that ships the blazing‑fast [Niri](https://github.com/YaLTeR/niri) Wayland compositor out of the box together with a carefully curated set of desktop packages, codecs and quality‑of‑life tweaks.
It is built with [BlueBuild](https://blue-build.org/) and follows the Universal Blue packaging philosophy.

## Installation

> [!WARNING]
> [OSTree native containers are still considered experimental](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable).
> Proceed at your own discretion.

To **rebase an existing Fedora Atomic installation** to the latest `atomic‑niri` build:

1. Rebase to the *unsigned* image first to fetch the signing keys:
    ```bash
    rpm-ostree rebase ostree-unverified-registry:ghcr.io/ergolyam/atomic-niri:latest
    ```

2. Reboot:
    ```bash
    systemctl reboot
    ```

3. Rebase to the *signed* image:
    ```bash
    rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ergolyam/atomic-niri:latest
    ```

4. Reboot once more to start using `atomic‑niri`:
    ```bash
    systemctl reboot
    ```
    - The `latest` tag always points to the newest build but **never** jumps across Fedora major releases the underlying release is fixed to the version declared in [`recipe.yml`](recipes/recipe.yml) (currently `42`).

## ISO

- Already on Fedora Atomic? You can generate an *offline* ISO containing `atomic‑niri` by following the instructions in the [Universal Blue documentation](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso).
- Pre‑built ISOs are not hosted here because of GitHub’s file‑size limits.

## Verification

Every container image is signed with [Sigstore](https://www.sigstore.dev/) via [cosign](https://github.com/sigstore/cosign).

1. Download [`cosign.pub`](./cosign.pub) from this repository.
2. Verify the signature:
    ```bash
    cosign verify --key cosign.pub ghcr.io/ergolyam/atomic-niri
    ```
    - Successful verification proves the image was built by this repository’s CI.

## Features

- **Niri compositor** for a modern, performance‑oriented Wayland desktop
- **Greetd + Tuigreet** lightweight TUI display manager
- Rich graphical and CLI software selection (Waybar, wofi, Thunar, kanshi, mako, ffmpeg, etc.)
- Automatic **rpm‑ostree**, **Flatpak** and **Podman** updates enabled by default
- Pre‑configured **Homebrew** integration (`just brew`)
- Laptop‑friendly power management with TLP & tuned‑ppd
- Full multimedia support via RPM Fusion and Negativo17 codecs
- Kernel replacement logic and deterministic initramfs regeneration for reproducible builds
