# Supercollider
Definitely the wrong place for this documentation but nevermnind that

## Deployment
Use precompiled supercollider from https://github.com/redFrik/supercolliderStandaloneRPI64. Follow the installation instructions there, except that I dont have an audio output. Initially I create a loopback device and let jack refer to this.
```
sudo modprobe snd-aloop
aplay -l
echo /usr/local/bin/jackd -P75 -p16 -dalsa -dhw:2,0,0 -r44100 -p1024 -n3 > ~/.jackdrc
```

# Darkice
I am using darkice to connect supercollider up to icecast. The config is found [here](./darkice_conf.toml).

I compiled darkice from the source (using the trunk subfolder). I needed some dependencies inluding the lame encoder which I istalled using `sudo apt install`. 

# How it all connects

So the first service to deploy is the darkice service. It runs this command:
```
darkice -c ~/repos/pi-collider/darkice_conf.toml
```
using `User=username`(important as we run the supercollider as <username> as well)
This service fires up jack and creates a darkice client.

Next up we deploy the supercollider service which depends on the darkice service (so it has jack up and running with the correct output links to darkice-left/right). The command run is:
```
/home/usrname/programs/supercolliderStandaloneRPI64/sclang -a -l /home/usernamer/programs/supercolliderStandaloneRPI64/sclang.yaml /home/username/repos/pi-collider/scd/osc.scd
```
This service is also run with `User=username`

Note: All this assumes you have icecast up and running ready to receive on port 8000/stream.

# Jacktools
To check my connections and during debugging I needed jacktools. But as we bulilt jack2 from source and installing jack tools using `sudo apt` would overwrite this jack2 with their version, I had to build jack tools from the source as well. This was allright, just follow the instructions in the [repo](https://github.com/jackaudio/jack-example-tools)
