echo "cgroup_memory=1 cgroup_enable=memory" >> /boot/firmware/cmdline.txt
# in the end of the line ^
# example: console=serial0,115200 console=tty1 root=PARTUUID=58b06195-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait cgroup_memory=1 cgroup_enable=memory

#check iptables
iptables --version



curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server \
    --disable-kube-proxy \
    --disable-network-policy \
    --flannel-backend=none \
    --disable=servicelb \
    --disable=traefik" sh -

sudo mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
export KUBECONFIG=~/.kube/config
