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
