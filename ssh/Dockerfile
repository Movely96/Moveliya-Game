# GCE lab SSH host. nmap/hydra target. Works on Windows/macOS/Linux via Docker.
FROM debian:12-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server sudo \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd

# Password login is required for this lab (hydra practices against it)
RUN sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

COPY create-users.sh /tmp/create-users.sh
RUN bash /tmp/create-users.sh && rm -f /tmp/create-users.sh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
