# Supercollider
Definitely the wrong place for this documentation but nevermnind that

## Deployment
Use precompiled supercollider from https://github.com/redFrik/supercolliderStandaloneRPI64. Follow the installation instructions there, except that I dont have an audio output. I create a loopback device and let jack refer to this.
```
sudo modprobe snd-aloop
aplay -l
echo /usr/local/bin/jackd -P75 -p16 -dalsa -dhw:Loopback,0 -r44100 -p1024 -n3 > ~/.jackdrc
```

echo /usr/local/bin/jackd -P75 -p16 -dalsa -dhw:Loopback,0 -r44100 -i2 -o2 -p1024 -n3 > ~/.jackdrc

# Darkice
I am using darkice to connect supercollider up to icecast. The config is found [here](./darkice_conf.toml).

The deployment was a bit of a faff, using `sudo apt` installed a Jack2 dependency which clashed with supercollider. Building from source led to a bunch of different problems. So I installed it without dependencies:
```
apt download darkice
sudo dpkg -i darkice_1.3-0.3+b1_arm64.deb
```
You also need to install the lame encoder, you can use sudo apt for that.
