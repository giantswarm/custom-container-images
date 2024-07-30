FROM --platform=linux/amd64 ubuntu/squid:5.6-22.10_beta@sha256:341611dd7eb3b2905e1d2e0cf1936606625dcab4085baf7cc4ae21c490670ac0

RUN sed -i '/^acl SSL_ports port 443/a acl SSL_ports port 6443' /etc/squid/squid.conf

RUN sed -i 's/http_access deny CONNECT/#http_access deny CONNECT/g' /etc/squid/squid.conf

RUN chmod a+rwx /run && chmod a+rwx /var/log/squid && chmod a+rwx /var/spool/squid

USER proxy

CMD ["squid", "-N"]


- image: ubuntu/squid
  sha: 341611dd7eb3b2905e1d2e0cf1936606625dcab4085baf7cc4ae21c490670ac0
  tag_or_pattern: "5.6-22.10_beta"
  add_tag_suffix: giantswarm_gs1
  dockerfile_extras:
    -
    -
    -
    -
    -
