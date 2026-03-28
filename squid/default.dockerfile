FROM --platform=linux/amd64 ubuntu/squid:5.6-22.10_beta@sha256:6c45354bab858078ce404e942b8a31a4d295027eb0fea35a42ca8b40c02f1d4e

RUN sed -i '/^acl SSL_ports port 443/a acl SSL_ports port 6443' /etc/squid/squid.conf

RUN sed -i 's/http_access deny CONNECT/#http_access deny CONNECT/g' /etc/squid/squid.conf

RUN chmod a+rwx /run && chmod a+rwx /var/log/squid && chmod a+rwx /var/spool/squid

USER proxy

CMD ["squid", "-N"]
