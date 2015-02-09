# Adafruit Occidentalis

Occidentalis is a collection of packages intended for use on a Raspberry Pi
running the latest version of the Raspbian distribution.  By default, it
installs a collection of development tools and a configuration helper called
`occi`.  It also provides a custom kernel build and configuration helpers for
various Adafruit products.

## Installing Occidentalis

### The Easy Way

Check out [our Pi Finder][finder], a graphical, cross-platform tool for
locating a Raspberry Pi on your network and configuring it with Occidentalis.

### The Easy Way (Command Line Edition)

On your Raspberry Pi, open a terminal and enter the following:

```
sudo -s
echo "deb http://apt.adafruit.com/raspbian/ wheezy main" >> /etc/apt/sources.list
wget -O - -q https://apt.adafruit.com/apt.adafruit.com.gpg.key | apt-key add -
apt-get update
apt-get install occidentalis
```

There's also [a handy installation script][install.sh] to do the same thing.  You can
inspect it with:

```
curl -SLs https://apt.adafruit.com/install | less
```

And, assuming you trust us, run it with:

```
curl -SLs https://apt.adafruit.com/install | sudo bash
```

[install.sh]: https://github.com/adafruit/Adafruit-Occidentalis/blob/master/install.sh
[finder]: https://github.com/adafruit/Adafruit-Pi-Finder
