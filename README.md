adafruit-pi-externalroot-helper
===============================

A shell script for configuring an external USB drive as root filesystem
on a Raspberry Pi running Raspbian.

Adafruit Learning System guide coming soon.

usage
-----

On a Raspberry Pi running Raspbian, with a USB-connected storage device you
wish to use for your root filesystem:

    git clone git@github.com:adafruit/Adafruit-Pi-ExternalRoot-Helper.git
    cd Adafruit-Pi-ExternalRoot-Helper
    sudo ./adafruit-pi-externalroot-helper -d /dev/sda

...where `/dev/sda` is the external USB you wish to use for a root filesystem.

credit where due and further reading
------------------------------------

This is mostly an implementation of the process outlined in paulv's
[HOWTO: Move the filesystem to a USB stick][1] on the Raspberry Pi
forums, with additional help from the following sources:

- The Arch Linux wiki, [GUID Partition Table][2] for what a GPT is and
  some `parted` commands.
- [GUID Partition Table][wp], Wikipedia
- [Booting from an external USB drive][3], from the Raspberry Pi StackExchange.
- [Booting a Raspberry Pi reliably from USB in the presence of multiple USB drives][4],
  by Stefan Krastanov.
- [Speed up your Pi by booting to a USB flash drive][5], by Sam Hobbs.
- [This comment][6] on `root=` in `init/do_mounts.c` in the Linux source tree.

Along with manual / info pages for:

- [gdisk](http://manpages.debian.org/cgi-bin/man.cgi?query=gdisk&apropos=0&sektion=0&manpath=Debian+7.0+wheezy&format=html&locale=en)
- [parted](http://manpages.debian.org/cgi-bin/man.cgi?query=parted&apropos=0&sektion=0&manpath=Debian+7.0+wheezy&format=html&locale=en)
- [blkid](http://manpages.debian.org/cgi-bin/man.cgi?query=blkid&apropos=0&sektion=0&manpath=Debian+7.0+wheezy&format=html&locale=en)
- [mkfs](http://manpages.debian.org/cgi-bin/man.cgi?query=mkfs&apropos=0&sektion=0&manpath=Debian+7.0+wheezy&format=html&locale=en)
- [tune2fs](http://manpages.debian.org/cgi-bin/man.cgi?query=tune2fs&apropos=0&sektion=0&manpath=Debian+7.0+wheezy&format=html&locale=en)

[1]: https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=44177
[2]: https://wiki.archlinux.org/index.php/GUID_Partition_Table
[3]: http://raspberrypi.stackexchange.com/questions/12404/booting-from-an-external-usb-drive
[4]: http://blog.krastanov.org/2014/01/30/booting-pi-reliably-from-usb/
[5]: https://samhobbs.co.uk/2013/10/speed-up-your-pi-by-booting-to-a-usb-flash-drive
[wp]: https://en.wikipedia.org/wiki/GUID_Partition_Table
[6]: https://github.com/torvalds/linux/blob/10975933da3d65f8833d4ce98dcc2ecc63a695d6/init/do_mounts.c#L183
