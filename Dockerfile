FROM golang:latest AS build
  RUN go get -tags netgo github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-server

FROM busybox
  ENV ENCRYPTION=aes-128-cfb
  EXPOSE 443/tcp
  USER nobody:nogroup
  COPY --from=build /go/bin/shadowsocks-server /usr/sbin
  CMD /usr/sbin/shadowsocks-server -p 443 -m $ENCRYPTION -k 170826