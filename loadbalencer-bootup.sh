#!/bin/sh
set -o errexit
kind create cluster --config kind-config.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s
docker network inspect -f '{{.IPAM.Config}}' kind
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-config.yaml
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml
LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')