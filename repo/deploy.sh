#!/usr/bin/env bash

NODE_DEB='node_0.12.6_armhf.deb'
IDE_DEB='adafruitwebide-0.3.11-Linux.deb'
RUN_DATE=`date '+%Y-%m-%d-%I:%M:%S'`

# incomplete notes:
#   - this whole script is by now sort of a bad idea
#   - stuff will break if there are spaces in filenames,
#     so don't do that or fix the quoting first
#   - we keep old snapshots for wheezy debs in ~/wheezy_deb_cache
#     but overwrite them if there have been new ones made for jessie

# make sure user passed a path to the repo
if [ "$1" == "" ]; then
  echo "You must specify a path to your pi_bootstrap repo. i.e. /home/admin/pi_bootstrap"
  exit 1
fi

# confirm we are working with the right folder
if [ ! -f $1/finder.sh ]; then
  echo "Are you sure ${1} is the correct path to the repo? finder.sh check failed."
  exit 1
fi

# deploy latest finder shell script
cd /var/packages/bootstrap
rm index.txt
cp $1/finder.sh index.txt
chmod 644 index.txt

# deploy latest install shell script
mkdir -p /var/packages/install
cd /var/packages/install
rm index.txt
cp $1/install.sh index.txt
chmod 644 index.txt

# deploy latest addrepo shell script
mkdir -p /var/packages/add
cd /var/packages/add
rm index.txt
cp $1/addrepo.sh index.txt
chmod 644 index.txt

# deploy latest install shell script
mkdir -p /var/packages/add-pin
cd /var/packages/add-pin
cp $1/addrepo-pin.sh index.txt
chmod 644 index.txt

# deploy latest install shell script
mkdir -p /var/packages/install-pin
cd /var/packages/install-pin
cp $1/install-pin.sh index.txt
chmod 644 index.txt

# copy the packages to a temp folder, build them:
TEMP_DIR=`mktemp -d`
cp -r $1/packages/* $TEMP_DIR
mkdir $TEMP_DIR/build
cd $TEMP_DIR
make

# make the deb cache folder if it doesn't exist
mkdir -p ~/jessie_deb_cache

# cache the node deb
if [ ! -f ~/jessie_deb_cache/$NODE_DEB ]; then
  wget http://node-arm.herokuapp.com/node_latest_armhf.deb -O ~/deb_cache/$NODE_DEB
fi
# cache the webide deb
if [ ! -f ~/jessie_deb_cache/$IDE_DEB ]; then
  wget -P ~/jessie_deb_cache/ http://adafruit-download.s3.amazonaws.com/$IDE_DEB
fi

# copy all of the cached debs into the build dir
cp ~/jessie_deb_cache/*.deb $TEMP_DIR/build

# sign packages, and add them to the repo
dpkg-sig -k $GPG_KEY --sign builder $TEMP_DIR/build/*.deb

# this should be our target:

rm -rf ~/.aptly/

WHEEZY_SNAPSHOT="occidentalis-wheezy-$RUN_DATE"
JESSIE_SNAPSHOT="occidentalis-jessie-$RUN_DATE"

# add packages to an existing aptly repo - we use force-replace to overwrite
# any existing versions.  (for all i know, this could cause problems, but i
# don't think it has yet.)
aptly repo create occidentalis-wheezy
aptly repo create occidentalis-jessie

for file in `ls $TEMP_DIR/build/`; do
  if [ -f ~/wheezy_deb_cache/"$file" ]; then
    cp $TEMP_DIR/build/"$file" ~/wheezy_deb_cache/"$file"
  fi
done

# wheezy_deb_cache is old stuff, we are not touching it any more
aptly repo add --force-replace=true occidentalis-wheezy ~/wheezy_deb_cache/*.deb

aptly repo add --force-replace=true occidentalis-jessie $TEMP_DIR/build/*.deb
aptly snapshot create $WHEEZY_SNAPSHOT from repo occidentalis-wheezy
aptly snapshot create $JESSIE_SNAPSHOT from repo occidentalis-jessie

# aptly publish drop wheezy
aptly publish snapshot --distribution="wheezy" $WHEEZY_SNAPSHOT
# aptly publish drop jessie
aptly publish snapshot --distribution="jessie" $JESSIE_SNAPSHOT

REPO_TEMP_DIR=`mktemp -d`
cp -r ~/.aptly/public/ $REPO_TEMP_DIR
rm -r /var/packages/raspbian
mv $REPO_TEMP_DIR/public /var/packages/raspbian

# clean up
rm -r $TEMP_DIR
rm -r $REPO_TEMP_DIR
