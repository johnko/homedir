# Lab

Following [Install Ubuntu Server 20.04 on Intel Compute Stick Guide](https://jamesachambers.com/install-ubuntu-server-18-04-on-intel-compute-stick-guide/) but use Ubuntu 22.04 LTS Server Edition

If you missed Wi-Fi configuration during installation, you can follow [this](https://www.makeuseof.com/connect-to-wifi-network-on-ubuntu-server/) or [this](https://gist.github.com/gnh1201/ca9c5a07642d3f71491d8ce8a949021f)

For Wi-Fi to work, may need to [reload the kernel module](https://ubuntuforums.org/showthread.php?t=2400427) with:

```bash
sudo modprobe r8723bs
sudo netplan apply
# check ip
sudo netplan ip leases wlan0
```
