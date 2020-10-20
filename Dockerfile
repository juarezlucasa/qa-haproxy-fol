FROM centos:7
ADD ["http://www.haproxy.org/download/1.8/src/haproxy-1.8.20.tar.gz", "/tmp/"]

RUN mkdir /etc/haproxy
RUN yum -y update && \
    yum -y install wget tar gcc pcre-static pcre-devel make perl etcd zlib-devel openssl-devel systemd-devel make git &&  \
    groupadd -r haproxy && \
    useradd -g haproxy -d /etc/haproxy -s /sbin/nologin  -c "Haproxy User" haproxy && \
    chown -R haproxy:haproxy /etc/haproxy && \
    chmod -R 774 /etc/haproxy && \
    cd /tmp/ && \
    tar -xvzf /tmp/haproxy-1.8.20.tar.gz && \
    cd /tmp/haproxy-1.8.20 && \
    make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 USE_CRYPT_H=1 USE_LIBCRYPT=1 USE_LINUX_TPROXY=1 USE_SYSTEMD=1 USE_THREAD=1 && \
    make install && \
    ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy && \
    yum clean all; 

WORKDIR /tmp
RUN git clone https://github.com/juarezlucasa/qa-haproxy-fol.git
RUN mv /tmp/qa-haproxy-fol/etcd.conf /etc/etcd/etcd.conf
RUN mv /tmp/qa-haproxy-fol/haproxy.cfg /etc/haproxy/haproxy.cfg

EXPOSE 80 443 13888 9000
USER haproxy 
CMD ["/usr/sbin/haproxy", "-W", "-f", "/etc/haproxy/haproxy.cfg"] 
