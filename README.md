# k8s_plex

Bootstrap a Plex media server in a `kind` cluster.

## Minimum Requirements

* macOS/Linux
* [kind](https://kind.sigs.k8s.io/)
* [helm](https://helm.sh/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [task](https://taskfile.dev/)

## Recommended Requirements

* [asdf](https://asdf-vm.com/)

## Setup

Copy the example files to the current directory.

```bash
cp kind-config.yaml.example kind-config.yaml
cp plex-values.yaml.example plex-values.yaml
```

Fill out the `kind-config.yaml` and `plex-values.yaml` files with the appropriate paths to your media files as well as the Plex claim token.

## Usage

The `bootstrap.sh` script is a simple bash script with minimal error handling.

The [taskfile](taskfiles/kind.yml) wraps the `bootstrap.sh` script with some additional functionality and error handling.

### bootstrap.sh

```bash
# help
./bootstrap.sh

# Create kind cluster
./bootstrap.sh create

# List kind clusters
./bootstrap.sh get

# Add nginx ingress controller
./bootstrap.sh add-ingress

# Install Plex Media Server
./bootstrap.sh install-plex

# Test Plex media server access
./bootstrap.sh smoke-test

# Delete kind cluster
./bootstrap.sh delete
```

### taskfile.yml

```bash
# help
task

# Create kind cluster
task kind:create

# List kind clusters
task kind:get

# Add nginx ingress controller
task kind:add-ingress

# Install Plex Media Server
task kind:install-plex

# Test Plex media server access
task kind:smoke-test

# Delete kind cluster
task kind:delete
```

## TODO

See [TODO.md](TODO.md) for pending tasks.

## Further Reading

* [Plex Pro Week ‘23: A–Z on K8s for Plex Media Server | Plex](https://www.plex.tv/blog/plex-pro-week-23-a-z-on-k8s-for-plex-media-server/)
* [plexinc/pms-docker](https://github.com/plexinc/pms-docker/tree/master/charts/plex-media-server)
* [Big Buck Bunny](https://peach.blender.org/download/)
