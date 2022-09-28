Docker images for Danbooru's instances of Postgres and OpenSMTPD.

* https://github.com/orgs/danbooru/packages
* https://github.com/orgs/danbooru/packages/container/package/postgres
* https://github.com/orgs/danbooru/packages/container/package/opensmtpd

* https://hub.docker.com/u/evazion
* https://hub.docker.com/r/evazion/postgres

# Build

```
# Generate personal access token at https://github.com/settings/tokens
echo $GITHUB_PAT | docker login ghcr.io --username danbooru --password-stdin
docker login docker.io

docker build --tag ghcr.io/danbooru/postgres:14.1 -f Dockerfile.postgres .
docker build --tag ghcr.io/danbooru/opensmtpd:latest -f Dockerfile.opensmtpd .

docker build --tag docker.io/evazion/postgres:14.1 -f Dockerfile.postgres .
docker build --tag docker.io/evazion/opensmtpd:latest -f Dockerfile.opensmtpd .

docker push ghcr.io/danbooru/postgres:14.1
docker push ghcr.io/danbooru/opensmtpd:latest

docker push docker.io/evazion/postgres:14.1
docker push docker.io/evazion/opensmtpd:latest
```

# Usage

```
docker run --rm -it ghcr.io/danbooru/opensmtpd:latest smtpd -d
docker run --rm -it ---shm-size=8g --network host e POSTGRES_USER=danbooru -e POSTGRES_HOST_AUTH_METHOD=trust -v $HOME/danbooru-postgres:/var/lib/postgresql/data ghcr.io/danbooru/postgres:14.1
```
