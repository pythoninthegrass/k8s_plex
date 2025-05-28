#!/usr/bin/env bash

export K8S_CLUSTER_NAME="kube-plex-cluster"
export KIND_CONFIG="kind-config.yaml"
export PLEX_CONFIG="plex-values.yaml"
export PLEX_NAMESPACE="plex-media-server"

# get kind clusters
get_clusters() {
	kind get clusters
}

start() {
	docker ps --filter "name=${K8S_CLUSTER_NAME}" -q | xargs -r docker start
}

stop() {
	docker ps --filter "name=${K8S_CLUSTER_NAME}" -q | xargs -r docker stop
}

# delete plex cluster
delete_cluster() {
	kind delete cluster --name $K8S_CLUSTER_NAME
}

# create plex cluster
create_cluster() {
	kind create cluster \
		--config $KIND_CONFIG \
		--name $K8S_CLUSTER_NAME
}

# add nginx ingress
add_ingress() {
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
	kubectl wait --namespace ingress-nginx \
		--for=condition=ready pod \
		--selector=app.kubernetes.io/component=controller   \
		--timeout=90s
}

# install plex media server
install_plex() {
	helm install kube-plex plex/plex-media-server \
		-f $PLEX_CONFIG \
		--create-namespace \
		--namespace plex-media-server
	helm repo update
}

# check data directory for movies
smoke_test() {
	kubectl exec \
		-it kube-plex-plex-media-server-0 \
		-n $PLEX_NAMESPACE \
		-- \
		ls -la /data/movies
}

usage() {
	echo "Usage: $(basename "$0") [create|delete|get|add-ingress|install-plex|smoke-test]"
}

main() {
	if [[ $# -eq 0 ]]; then
		usage
		exit 0
	elif [[ $# -eq 1 ]]; then
		case $1 in
			create)
				create_cluster
				;;
			delete)
				delete_cluster
				;;
			get)
				get_clusters
				;;
			add-ingress)
				add_ingress
				;;
			install-plex)
				install_plex
				;;
			smoke-test)
				smoke_test
				;;
			*)
				echo "Invalid option: $1"
				exit 1
				;;
		esac
	else
		echo "Too many arguments provided."
		usage
		exit 1
	fi
}
main "$@"
