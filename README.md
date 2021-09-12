# MyDocker
Docker repository for **ubuntu base**

- **Docker Build**

**build.sh** usage:
```markdown
Desc:
    Build docker image and/or push to docker hub
Usage:
    ./build.sh [-b] [-f DOCKERFILE] [-o HOST] [-r REPOSITORY] [-t TAG] [-c CONTEXT] [-p]
Options:
    -h, --help                   Help
    -b, --build                  Build docker image (optional)
    -f, --file DOCKERFILE        Docker file to build (optional, default: ./Dockerfile)
    -o, --host HSOT              Docker host (optional, default: happyhaoyuan)
    -r, --repo REPOSITORY        Docker repository (optional, default: zac)
    -t, --tag TAG                Tag for the image (optional, default: latest)
    -c, --context CONTEXT        Context to build (optional, default: .)
    -p, --push                   Push to docker hub (optional)
```

- **Docker Run**
```commandline
docker run -d
--restart="always"
--name zac
--hostname zac-hub
--memory=$(($(head -n 1 /proc/meminfo | awk '{print $2}') * 4 / 5))k
--cpus=$(($(nproc) - 2))
--log-opt max-size=50m
-p 5006:5006
-e DOCKER_USER=id -un
-e DOCKER_USER_ID=id -u
-e DOCKER_PASSWORD=id -un
-e DOCKER_GROUP_ID=id -g
-e DOCKER_ADMIN_USER=id -un
-v $(pwd):/workdir
-v $(dirname $HOME):/home_host
happyhaoyuan/zac:latest /scripts/sys/init.sh
```