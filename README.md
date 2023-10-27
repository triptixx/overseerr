[hub]: https://hub.docker.com/r/loxoo/overseerr
[git]: https://github.com/triptixx/overseerr/tree/main
[actions]: https://github.com/triptixx/overseerr/actions/workflows/main.yml

# [loxoo/overseerr][hub]
[![Git Commit](https://img.shields.io/github/last-commit/triptixx/overseerr/main)][git]
[![Build Status](https://github.com/triptixx/overseerr/actions/workflows/main.yml/badge.svg?branch=main)][actions]
[![Latest Version](https://img.shields.io/docker/v/loxoo/overseerr/latest)][hub]
[![Size](https://img.shields.io/docker/image-size/loxoo/overseerr/latest)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/overseerr.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/overseerr.svg)][hub]

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

- `$SUID`         - User ID to run as. _default: `951`_
- `$SGID`         - Group ID to run as. _default: `951`_
- `$TZ`           - Timezone. _optional_

## Volume

- `/config`       - Server configuration file location.

## Network

- `5055/tcp`      - WebUI.