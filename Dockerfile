FROM centos:7
LABEL maintainer="lucas.juarez@comafi.com.ar"
LABEL version="1.0"
LABEL description="Image con etcd y haproxy \
para proyecto FOL Postgresql activo pasivo"

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in ; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);
VOLUME [ “/sys/fs/cgroup” ]
CMD ["/usr/sbin/init"]

RUN yum -y update && yum install -y initscripts
RUN yum -y install etcd
RUN yum -y install gcc pcre-devel tar make git -y
RUN yum -y install haproxy

WORKDIR /tmp
RUN git clone https://github.com/juarezlucasa/qa-haproxy-fol.git

RUN mv /tmp/qa-haproxy-fol/etcd.conf /etc/etcd/etcd.conf
RUN mv /tmp/qa-haproxy-fol/haproxy.cfg /etc/haproxy/haproxy.cfg
