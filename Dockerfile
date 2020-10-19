FROM centos:7
LABEL maintainer="lucas.juarez@comafi.com.ar"
LABEL version="1.0"
LABEL description="Image con etcd y haproxy \
para proyecto FOL Postgresql activo pasivo"

RUN adduser default
WORKDIR /home/default/
RUN yum update
RUN yum install etcd
RUN yum install gcc pcre-devel tar make -y
RUN yum install haproxy

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
