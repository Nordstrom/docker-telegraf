FROM golang:1.8

WORKDIR /go/src/github.com/influxdata/telegraf
RUN git clone https://github.com/dylanmei/telegraf /go/src/github.com/influxdata/telegraf \
 && git checkout burrow-input-plugins \
 && make \
 && mkdir -p /etc/telegraf/telegraf.d \
 && cp etc/*.conf /etc/telegraf/ \
 && cp $GOPATH/bin/telegraf /usr/bin/ \
 && rm -rf /go/src/github.com

WORKDIR /

EXPOSE 8125/udp 8092/udp 8094

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["telegraf"]
