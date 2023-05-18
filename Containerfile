FROM ghcr.io/cgwalters/fedora-oscore

COPY etc/systemd/system/first-boot-script.service /etc/systemd/system/first-boot-script.service
COPY etc/systemd/system-preset/00-build-defaults.preset /etc/systemd/system-preset/00-build-defaults.preset
COPY etc/first-boot.sh /etc/first-boot.sh
RUN systemctl preset first-boot-script.service && \
    mkdir -p /usr/etc-system/ && \
    echo 'AuthorizedKeysFile /usr/etc-system/%u.keys' >> /etc/ssh/sshd_config.d/30-auth-system.conf && \
    echo 'ssh-ed25519 AAA...eXN user@device' > /usr/etc-system/root.keys && chmod 0600 /usr/etc-system/root.keys && \
    ostree container commit
