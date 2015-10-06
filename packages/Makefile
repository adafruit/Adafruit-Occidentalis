occi_stuff = $(shell find occi)
occidentalis_stuff = $(shell find occidentalis)
pitft_stuff = $(shell find adafruit-pitft-helper_TEMPLATE)
externalroot_stuff = $(shell find adafruit-pi-externalroot-helper)
ap_stuff = $(shell find adafruit-ap)
gif_stuff = $(shell find adafruit-io-gif)

OCCIDENTALIS_VERSION := $(shell head -1 occidentalis/DEBIAN/changelog | sed 's/.*(//;s/).*//;')
OCCI_VERSION := $(shell head -1 occi/DEBIAN/changelog | sed 's/.*(//;s/).*//;')
EXTERNALROOT_VERSION := $(shell head -1 adafruit-pi-externalroot-helper/debian/changelog | sed 's/.*(//;s/).*//;')
AP_VERSION := $(shell head -1 adafruit-ap/DEBIAN/changelog | sed 's/.*(//;s/).*//;')
GIF_VERSION := $(shell head -1 adafruit-io-gif/DEBIAN/changelog | sed 's/.*(//;s/).*//;')

PITFT_PACKAGE_VERSION := $(shell head -1 adafruit-pitft-helper_TEMPLATE/debian/changelog | sed 's/.*(//;s/).*//;')
# the Perl line just gets the Adafruit-PiTFT-Helper version minus the -whatever
PITFT_VERSION := $(shell head -1 adafruit-pitft-helper_TEMPLATE/debian/changelog | perl -pe 's{ .* \( (.+) [-] \d+ \) .* }{\1}x;')

all: build/adafruit-ap_${AP_VERSION}_armhf.deb build/occi_${OCCI_VERSION}_armhf.deb build/occidentalis_${OCCIDENTALIS_VERSION}_armhf.deb build/adafruit-pitft-helper_${PITFT_PACKAGE_VERSION}_armhf.deb build/adafruit-io-gif_${GIF_VERSION}_armhf.deb build/adafruit-pi-externalroot-helper_${EXTERNALROOT_VERSION}_armhf.deb

build/occi_${OCCI_VERSION}_armhf.deb: ${occi_stuff}
	gzip occi/DEBIAN/changelog --best -c > occi/usr/share/doc/occi/changelog.gz
	pod2man occi/usr/bin/occi | gzip --best -c > occi/usr/share/man/man1/occi.1.gz
	fakeroot dpkg-deb -b occi build/occi_${OCCI_VERSION}_armhf.deb

build/occidentalis_${OCCIDENTALIS_VERSION}_armhf.deb: ${occidentalis_stuff}
	gzip occidentalis/DEBIAN/changelog --best -c > occidentalis/usr/share/doc/occidentalis/changelog.gz
	fakeroot dpkg-deb -b occidentalis build/occidentalis_${OCCIDENTALIS_VERSION}_armhf.deb

build/adafruit-ap_${AP_VERSION}_armhf.deb: ${ap_stuff}
	gzip adafruit-ap/DEBIAN/changelog --best -c > adafruit-ap/usr/share/doc/adafruit-ap/changelog.gz
	fakeroot dpkg-deb -b adafruit-ap build/adafruit-ap_${AP_VERSION}_armhf.deb

build/adafruit-io-gif_${GIF_VERSION}_armhf.deb: ${gif_stuff}
	gzip adafruit-io-gif/DEBIAN/changelog --best -c > adafruit-io-gif/usr/share/doc/adafruit-io-gif/changelog.gz
	fakeroot dpkg-deb -b adafruit-io-gif build/adafruit-io-gif_${GIF_VERSION}_armhf.deb

# I'm sorry
build/adafruit-pitft-helper_${PITFT_PACKAGE_VERSION}_armhf.deb: ${pitft_stuff}
	mkdir -p adafruit-pitft-helper
	rm -r adafruit-pitft-helper
	mkdir adafruit-pitft-helper
	cd adafruit-pitft-helper && wget https://github.com/adafruit/Adafruit-PiTFT-Helper/archive/jessie.tar.gz -O adafruit-pitft-helper_${PITFT_VERSION}.orig.tar.gz
	cd adafruit-pitft-helper && tar xvzf adafruit-pitft-helper_${PITFT_VERSION}.orig.tar.gz
	cd adafruit-pitft-helper && mv Adafruit-PiTFT-Helper-jessie adafruit-pitft-helper_${PITFT_VERSION}
	cp -r adafruit-pitft-helper_TEMPLATE/debian adafruit-pitft-helper/adafruit-pitft-helper_${PITFT_VERSION}/
	cd adafruit-pitft-helper/adafruit-pitft-helper_${PITFT_VERSION} && debuild -b -aarmhf -uc -us
	mv ./adafruit-pitft-helper/*.deb build/
	rm -r adafruit-pitft-helper

build/adafruit-pi-externalroot-helper_${EXTERNALROOT_VERSION}_armhf.deb: ${externalroot_stuff}
	mkdir -p erbuild
	rm -r erbuild
	mkdir erbuild
	cp -r adafruit-pi-externalroot-helper erbuild/adafruit-pi-externalroot-helper_${EXTERNALROOT_VERSION}
	cd erbuild/adafruit-pi-externalroot-helper_${EXTERNALROOT_VERSION} && debuild -b -aarmhf -uc -us
	mv ./erbuild/*.deb build/
	rm -r erbuild

clean:
	$(RM) build/*
