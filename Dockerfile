FROM alpine:3.14

ARG BUILD_DATE=none
ARG VCS_REF=none
ARG VERSION=none

LABEL org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.authors="Alexandre Garnier <zigarn@gmail.com>" \
      org.opencontainers.image.url="https://github.com/zigarn/docker-nextcloud-client" \
      org.opencontainers.image.documentation="https://github.com/zigarn/docker-nextcloud-client/blob/$VCS_REF/README.md" \
      org.opencontainers.image.source="https://github.com/zigarn/docker-nextcloud-client.git" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.vendor="Zigarn" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="docker-nextcloud-client" \
      org.opencontainers.image.description="Nextcloud client docker image for Nextcloud synchronization"

# Install nextcloud-client (3.1.3)
RUN apk add --no-cache nextcloud-client

# Data volumes
VOLUME /data /log

# Configuration
VOLUME /conf
RUN ln -s /conf/.netrc ~/.netrc
ENV SERVER ''
ENV DAVPATH '/remote.php/dav'
ENV PERIODICITY '0 * * * *'
ENV LANG 'C.UTF-8'

# Synchronization
ADD run_sync.sh /run_sync.sh
CMD /run_sync.sh
