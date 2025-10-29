FROM quay.io/fedora/fedora-bootc:43

COPY rootfs /

RUN rm -rf /usr/local &&\
    rm -rf /opt &&\
    ln -s /var/usrlocal /usr/local &&\
    ln -s /var/opt /opt

RUN dnf -y install \
    @core \
    @hardware-support \
    @standard \
    @base-graphical \
    glibc-all-langpacks \
    --exclude dracut-config-rescue

RUN dnf -y install $(grep -vE '^\s*#|^\s*$' /tmp/packages.txt)

RUN dnf -y clean all

RUN rm -rf /var/log/* &&\
    rm -rf /var/cache/*

RUN glib-compile-schemas /usr/share/glib-2.0/schemas

RUN systemctl enable $(grep -vE '^\s*#|^\s*$' /tmp/system-services.txt)

RUN systemctl --global enable $(grep -vE '^\s*#|^\s*$' /tmp/user-services.txt)

RUN sh /tmp/addimageinfo.sh

RUN bootc container lint --no-truncate
