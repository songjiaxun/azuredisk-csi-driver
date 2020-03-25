#!/bin/bash

# Copyright 2020 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

ver="master"
if [[ "$#" -gt 0 ]]; then
  ver="$1"
fi

repo="https://raw.githubusercontent.com/kubernetes-sigs/azuredisk-csi-driver/master/deploy"
if [ $ver != "master" ]; then
	repo="$repo/$ver"
fi

echo "Uninstalling Azure Disk CSI driver, version: $ver ..."
kubectl delete -f  $repo/csi-azuredisk-controller.yaml --ignore-not-found
kubectl delete -f  $repo/csi-azuredisk-node.yaml --ignore-not-found
kubectl delete -f  $repo/csi-azuredisk-node-windows.yaml --ignore-not-found
kubectl delete -f  $repo/csi-azuredisk-driver.yaml --ignore-not-found
kubectl delete -f  $repo/crd-csi-node-info.yaml --ignore-not-found
kubectl delete -f  $repo/rbac-csi-azuredisk-controller.yaml --ignore-not-found
echo 'Uninstalled Azure Disk CSI driver successfully.'
