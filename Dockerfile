FROM alpine:3.9

RUN apk add --update --no-cache --virtual=run-deps \
  python3 \
  ca-certificates \
  && rm -rf /var/cache/apk/*

RUN pip3 install --no-cache-dir awscli
COPY sync.sh /
CMD ["./sync.sh"]
