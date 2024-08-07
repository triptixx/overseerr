ARG ALPINE_TAG=3.20
ARG OVERSEERR_VER=1.33.2

FROM node:alpine AS builder

ARG OVERSEERR_VER
ENV COMMIT_TAG="${OVERSEERR_VER}" \
    NODE_OPTIONS=--openssl-legacy-provider

### install overseerr
WORKDIR /output/overseerr
RUN apk add --no-cache git; \
    git clone https://github.com/sct/overseerr.git --branch v${OVERSEERR_VER} /overseerr-src; \
    cp -a /overseerr-src/.eslintrc.js /overseerr-src/babel.config.js /overseerr-src/next-env.d.ts \
        /overseerr-src/next.config.js /overseerr-src/ormconfig.js /overseerr-src/package.json \
        /overseerr-src/postcss.config.js /overseerr-src/stylelint.config.js /overseerr-src/tailwind.config.js \
        /overseerr-src/tsconfig.json /overseerr-src/yarn.lock /overseerr-src/overseerr-api.yml .; \
    yarn install --frozen-lockfile --network-timeout 1000000; \
    cp -a /overseerr-src/server /overseerr-src/src /overseerr-src/public .; \
    yarn run build; \
    yarn install --production --ignore-scripts --prefer-offline; \
    echo "{\"commitTag\": \"${OVERSEERR_VER}\"}" > committag.json; \
    ln -s /config config; \
    rm -rf src server .eslintrc.js babel.config.js next-env.d.ts next.config.js postcss.config.js \
        stylelint.config.js tailwind.config.js tsconfig.json yarn.lock

COPY *.sh /output/usr/local/bin/
RUN chmod +x /output/usr/local/bin/*.sh

#============================================================

FROM loxoo/alpine:${ALPINE_TAG}

ARG OVERSEERR_VER
ENV SUID=951 SGID=951

LABEL org.label-schema.name="overseerr" \
      org.label-schema.description="Request management and media discovery tool for the Plex ecosystem" \
      org.label-schema.url="https://docs.overseerr.dev" \
      org.label-schema.version=${OVERSEERR_VER}

COPY --from=builder /output/ /

WORKDIR /overseerr
RUN apk add --no-cache yarn

VOLUME ["/config"]

EXPOSE 5055/TCP

HEALTHCHECK --start-period=10s --timeout=5s \
    CMD wget -qO /dev/null "http://127.0.0.1:5055/api/v1/status"

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["yarn", "start"]