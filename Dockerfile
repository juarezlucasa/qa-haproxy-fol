FROM andresb39/haproxycentos:v2
LABEL version="1.0"
LABEL mainteiner="J. Andres Bergano <andresb39@gmail.com>"

WORKDIR /tmp
RUN git clone https://github.com/juarezlucasa/qa-haproxy-fol.git
RUN mv /tmp/qa-haproxy-fol/haproxy.cfg /etc/haproxy/haproxy.cfg
RUN mv /tmp/qa-haproxy-fol/etcd.conf /etc/etcd/etcd.conf

EXPOSE 80 5432 7000

USER haproxy

CMD [ "/usr/sbin/haproxy", "-f", "/etc/haproxy/haproxy.cfg", "-p", "/run/haproxy.pid", "-Ds" ]
