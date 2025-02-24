#
# This is a script to simplify the instructions found at:
# https://www.cherryservers.com/blog/install-kubernetes-ubuntu
# Which is the only set of instructions I have found that actually work
#
set -e 

if [ $# -eq 0 ]
  then
    echo "You need to input the Kubernetes version."
fi


K8S_VERSION=$1

sudo apt install ubuntu-desktop -y
sudo apt install open-vm-tools open-vm-tools-desktop -y
sudo apt update
sudo apt update && sudo apt upgrade
sudo swapoff -a
swapon --show
sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/modules-load.d/k8s.conf <<EOF
overlay
br_netfilter
EOF
sudo tee /etc/sysctl.d/k8s.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward   = 1
EOF
sudo sysctl --system
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl status docker
sudo systemctl enable docker
sudo mkdir /etc/containerd
sudo sh -c "containerd config default > /etc/containerd/config.toml"
sudo sed -i 's/ SystemdCgroup = false/ SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd.service
sudo systemctl status containerd.service
sudo apt-get install curl ca-certificates apt-transport-https  -y
curl -fsSL https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${K8S_VERSION}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install kubelet kubeadm kubectl -y

