FROM quay.io/fedora/fedora-bootc:43

COPY rootfs /

RUN dnf -y copr enable yalter/niri

RUN dnf -y install $(grep -vE '^\s*#|^\s*$' /tmp/packages.txt)

RUN glib-compile-schemas /usr/share/glib-2.0/schemas

RUN systemctl enable $(grep -vE '^\s*#|^\s*$' /tmp/system-services.txt)

RUN systemctl --global enable $(grep -vE '^\s*#|^\s*$' /tmp/user-services.txt)

RUN sh /tmp/addimageinfo.sh

RUN bootc container lint
