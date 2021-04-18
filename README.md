[hub]: https://hub.docker.com/r/loxoo/overseerr
[mbdg]: https://microbadger.com/images/loxoo/overseerr
[git]: https://github.com/triptixx/overseerr
[actions]: https://github.com/triptixx/overseerr/actions

# [loxoo/overseerr][hub]
[![Layers](https://images.microbadger.com/badges/image/loxoo/overseerr.svg)][mbdg]
[![Latest Version](https://images.microbadger.com/badges/version/loxoo/overseerr.svg)][hub]
[![Git Commit](https://images.microbadger.com/badges/commit/loxoo/overseerr.svg)][git]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/overseerr.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/overseerr.svg)][hub]
[![Build Status](https://github.com/triptixx/overseerr/workflows/docker%20build/badge.svg)][actions]

## Usage

```shell
docker run -d \
    --name=srvoverseerr \
    --restart=unless-stopped \
    --hostname=srvoverseerr \
    -p 5055:5055 \
    -v $PWD/config:/config \
    loxoo/overseerr
```

## Environment

- `$SUID`         - User ID to run as. _default: `952`_
- `$SGID`         - Group ID to run as. _default: `952`_
- `$TZ`           - Timezone. _optional_

## Volume

- `/config`       - Server configuration file location.

## Network

- `5055/tcp`      - WebUI.