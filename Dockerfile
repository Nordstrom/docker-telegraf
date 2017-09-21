FROM golang:1.8

WORKDIR /go/src/github.com/influxdata/telegraf
RUN git clone https://github.com/dylanmei/telegraf /go/src/github.com/influxdata/telegraf \
 && git checkout jolokia2 \
 && make \
 && mkdir -p /etc/telegraf/telegraf.d \
 && cp etc/*.conf /etc/telegraf/ \
 && cp telegraf /usr/bin/ \
 && rm -rf /go/src /go/pkg /go/bin

WORKDIR /

EXPOSE 8125/udp 8092/udp 8094

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["telegraf"]
