# atomic-niri
`atomic-niri` is a custom [Fedora Bootc](https://docs.fedoraproject.org/en-US/bootc/) image that ships the blazing‑fast [Niri](https://github.com/YaLTeR/niri) Wayland compositor out of the box together with a carefully curated set of desktop packages.


To **rebase an existing Fedora Bootc installation** to the latest `atomic‑niri` build:

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
    - The `latest` tag always points to the newest build but **never** jumps across Fedora major releases the underlying release is fixed to the version declared in [`containerfile`](containerfile).
