# GCE lab host - Ubuntu + OpenSSH with the three staff accounts.
# Players scan this with nmap and brute-force it with hydra over SSH, then
# su/ssh into each account to find the hidden portal credentials.
FROM ubuntu:24.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        openssh-server sudo \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/sshd

# Allow password logins so the intended hydra/ssh solve path works.
RUN sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config

COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

EXPOSE 22
CMD ["/usr/local/bin/init.sh"]
