echo "cgroup_memory=1 cgroup_enable=memory" >> /boot/firmware/cmdline.txt
# in the end of the line ^
# example: console=serial0,115200 console=tty1 root=PARTUUID=58b06195-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait cgroup_memory=1 cgroup_enable=memory

#check iptables
iptables --version

#before k3s install, put the config.yaml file in /etc/rancher/k3s/

curl -sfL https://get.k3s.io | sh -

sudo mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
export KUBECONFIG=~/.kube/config
