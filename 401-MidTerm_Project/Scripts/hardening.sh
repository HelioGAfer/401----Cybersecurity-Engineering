apt-get install wget sed git -y

apt-get update -y && apt-get full-upgrade -y

rm -rf /usr/local/go
wget -q -c https://dl.google.com/go/$(curl -s https://golang.org/VERSION?m=text).linux-amd64.tar.gz -O go.tar.gz
tar -C /usr/local -xzf go.tar.gz
echo "export GOROOT=/usr/local/go" >> /etc/profile
echo "export PATH=/usr/local/go/bin:$PATH" >> /etc/profile
source /etc/profile
rm go.tar.gz

wget -q -c https://raw.githubusercontent.com/conduro/ubuntu/main/sysctl.conf -O /etc/sysctl.conf

# IP Spoofing protection
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Ignore ICMP broadcast requests
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Disable source packet routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0 
net.ipv4.conf.default.accept_source_route = 0
net.ipv6.conf.default.accept_source_route = 0

# Ignore send redirects
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

# Block SYN attacks
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 2048
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 5

# Log Martians
net.ipv4.conf.all.log_martians = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1

# Ignore ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0 
net.ipv6.conf.default.accept_redirects = 0

# Ignore Directed pings
net.ipv4.icmp_echo_ignore_all = 1

# Disable IPv6
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

# Hide kernel pointers
kernel.kptr_restrict = 2

# Enable panic on OOM
vm.panic_on_oom = 1

# Reboot kernel ten seconds after OOM
kernel.panic = 10

ufw disable
echo "y" | sudo ufw reset
ufw logging off
ufw default deny incoming
ufw default allow outgoing
ufw allow 80/tcp
ufw allow 443/tcp

# optional prompt to change ssh port
    ufw allow ${prompt}/tcp
    sed -i "/Port /Id" /etc/ssh/sshd_config
    echo "Port ${prompt}" | sudo tee -a /etc/ssh/sshd_config
# defaults to port 22
    ufw allow 22/tcp

sed -i "/ipv6=/Id" /etc/default/ufw
echo "IPV6=no" | sudo tee -a /etc/default/ufw

sed -i "/GRUB_CMDLINE_LINUX_DEFAULT=/Id" /etc/default/grub
echo "GRUB_CMDLINE_LINUX_DEFAULT=\"ipv6.disable=1 quiet splash\"" | sudo tee -a /etc/default/grub

find /var/log -type f -delete
rm -rf /usr/share/man/*
apt-get autoremove -y
apt-get autoclean -y

sysctl -p
update-grub2
ufw --force enable

