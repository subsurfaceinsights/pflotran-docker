set -e
DOCKER_BUILDKIT=1 docker build --target=pflotran-build-env . -t subsurfaceinsights/pflotran-build-env
cwd=$(pwd)
docker run -v "$cwd":"$cwd" --user "$UID" -w "$cwd"  -ti subsurfaceinsights/pflotran-build-env
