# Nextcloud client docker image for nextcloud synchronization

[![Build Status](https://github.com/zigarn/docker-nextcloud-client/actions/workflows/docker.yml/badge.svg)](https://github.com/zigarn/docker-nextcloud-client/actions/workflows/docker.yml)

![Docker Image Version (latest by date)](https://img.shields.io/docker/v/zigarn/nextcloud-client)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/zigarn/nextcloud-client)
![Docker Pulls](https://img.shields.io/docker/pulls/zigarn/nextcloud-client)

## Configuration

Create a configuration folder with 2 files :

  - `.netrc`: [netrc](http://linux.die.net/man/5/netrc) configuration file for authentication on nextcloud server. E.g `default login mylogin password mypassword`
  - `sync-exclude.lst`: list of files or folder to exclude in the format generated by the [Ignored Files Editor](https://docs.nextcloud.com/desktop/3.1/navigating.html#using-the-ignored-files-editor)

## Use

Launch the docker image with:

 - Volumes:
   - `/data`: folder of synced data
   - `/log`: folder for sync logs
   - `/conf`: folder containing configuration files
 - Env:
   - `LANG`: the `LANG` for encoding in file names. Defaults to 'C.UTF-8'
   - `SERVER`: the Nextcloud server URL
   - `DAVPATH`: the WebDAV path on the server. Defaults to '/remote.php/dav' (may have to change for '/remote.php/webdav')
   - `PERIODICITY`: sync periodicity in [crontab](http://linux.die.net/man/5/crontab) format (but DO NOT USE @xxx formats). Defaults to `0 * * * *` (hourly)

E.g:

```shell
docker run --detach \
  --volume ~/nextcloud-sync:/data \
  --volume /var/log:/log \
  --volume /etc/nextcloud-sync/:/conf \
  --env LANG=fr_FR.ISO-8859-15 \
  --env SERVER=http://nextcloud.server.com/ \
  --env PERIODICITY='*/15 * * * *' \
  zigarn/nextcloud-client
```
