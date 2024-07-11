# Open5GS deployment on K8s
## This repo implements Open5GS Core Network using Kubernetes and Helm (inspired by towards5gs-helm repo)

#### Important Note
> All docker images are pushed to docker hub, but feel free to build them for development purpose.

#### 1. Installation of K8s cluster
Please follow these steps to setup a K8s cluster

1) Adding K8s and CRI-O packages
**/!\\ We suppose having a Linux distribution using ``deb`` packages (Debian, Ubuntu) /!\\**
For RPM packages, please follow instructions on https://github.com/cri-o/packaging?tab=readme-ov-file#distributions-using-rpm-packages

 - Dependencies

```shell
apt-get update
apt-get install -y software-properties-common curl
```
 - Defining packages version
 
```shell
KUBERNETES_VERSION=v1.28
PROJECT_PATH=stable:/v1.28
```
 - Adding repositories

```shell

## For K8s
curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key |
    sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /" |
    sudo tee /etc/apt/sources.list.d/kubernetes.list

## For CRI-O
curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/$PROJECT_PATH/deb/Release.key |
    sudo gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/$PROJECT_PATH/deb/ /" |
    sudo tee /etc/apt/sources.list.d/cri-o.list
```

 - Install packages
```shell
sudo apt-get update
sudo apt-get install -y cri-o kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

2) Create the cluster

- Start CRI-O
```shell
sudo systemctl start crio.service
```

 - Deactivate SWAP permanently
```shell
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a
sudo mount -a
```

 - Enable br_netfilter and overlay
```shell
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
overlay
EOF
modprobe br_netfilter 
modprobe overlay
```

 - IPTables conf and IP fowarding
```shell
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system
```

 - Init the K8s control plane
```shell
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 ## Choose relevant pod CIDR
```

 - **To use kubectl**
```shell
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

 - Add kubectl alias with completion
```shell
echo "source <(kubectl completion bash)" >> ~/.bashrc
echo "alias k=kubectl" >> ~/.bashrc
echo "complete -o default -F __start_kubectl k" >> ~/.bashrc
source .bashrc
```

#### 2. Installation of CNI and Multus
Follow these steps to install a CNI plugin and Multus to enable multi network interfaces per pod

1) Installation of CNI plugin
> We will install Calico as a CNI here, but one can choose Flannel as well

 - Install Tigera and CRD

```shell
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.4/manifests/tigera-operator.yaml

## Download and modify the cidr in custom-resource.yaml if not 192.168.0.0/16
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.4/manifests/custom-resources.yaml
```

Then, wait until all pods have the status ``running``.

 - Remove control plane taints

```shell
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl taint nodes --all node-role.kubernetes.io/master-
```

2) Installation of Multus
We will install Multus to enable the use of multiple network interfaces on a pod. It is useful to provide network isolation and better management of network traffic.

 - Fetch Multus

 ```shell
 git clone https://github.com/k8snetworkplumbingwg/multus-cni.git
 cd multus-cni
 ```

 - Install Multus

```shell
cat ./deployments/multus-daemonset-thick.yml | kubectl apply -f -
```