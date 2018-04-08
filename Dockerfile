FROM alpine:edge
MAINTAINER Daniel Guerra
RUN apk add --update --no-cache iptables
ADD bin /bin
