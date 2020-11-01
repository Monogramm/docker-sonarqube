FROM alpine:latest

ADD docker_test.sh /docker_test.sh

RUN set -ex; \
    apk --no-cache add --update curl; \
    rm -rf /var/cache/apk/*; \
    chmod 755 /docker_test.sh;

CMD ["/docker_test.sh"]
