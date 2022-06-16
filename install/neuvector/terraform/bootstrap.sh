#!/bin/sh
PUBLIC_ADDRESS=$(curl http://checkip.amazonaws.com)

cat > /var/lib/rancher/k3s/server/manifests/nv.yaml << EOF
apiVersion: v1
kind: Namespace
metadata:
  name: neuvector-system
---
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: neuvector
  namespace: kube-system
spec:
  targetNamespace: neuvector-system
  repo: https://neuvector.github.io/neuvector-helm/
  chart: core
  version: v2.2.0
  helmVersion: v3
  set:
    registry: docker.io
    controller.image.repository: neuvector/controller
    controller.replicas: 1
    manager.image.repository: neuvector/manager
    manager.replicas: 1
    enforcer.image.repository: neuvector/enforcer
    cve.scanner.image.repository: neuvector/scanner
    cve.scanner.image.tag: latest
    cve.scanner.replicas: 1
    cve.updater.image.repository: neuvector/updater
    cve.updater.image.tag: latest
    tag: 5.0.0
    manager.ingress.enabled: "true"
    manager.ingress.host: neuvector.${PUBLIC_ADDRESS}.sslip.io
    manager.ingress.path: "/"
    manager.env.ssl: "false"
    k3s.enabled: "true"
EOF
