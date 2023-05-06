# Add dependent repositories
sudo dpkg --add-architecture i386
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
touch /etc/apt/sources.list.d/pika.list
echo 'deb https://ppa.pika-os.com/ lunar main' > /etc/apt/sources.list.d/pika.list
sudo apt update
#add-apt-repository ppa:pikaos/pika
#add-apt-repository ppa:kubuntu-ppa/backports
# Clone Upstream
wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gst-plugins-bad1.0/gst-plugins-bad1.0_1.22.1.orig.tar.xz
mkdir -p ./tar-arc
tar -xf ./gst-plugins-bad1.0_1.22.1-1ubuntu1.orig.tar.xz -C ./tar-arc/
mv ./tar-arc/* ./gst-plugins-bad1.0
cp -rvf ./debian ./gst-plugins-bad1.0/
cd ./gst-plugins-bad1.0

# Get build deps
ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
apt-get build-dep -y ./
debuild -S -uc -us
cd ../

apt-get install -y pbuilder debootstrap devscripts debhelper sbuild debhelper ubuntu-dev-tools piuparts

apt install -y debian-archive-keyring
cp -rvf ./pbuilderrc /etc/pbuilderrc
mkdir -p /var/cache/pbuilder/hook.d/
cp -rvf ./hooks/* /var/cache/pbuilder/hook.d/
rm -rf /var/cache/apt/
mkdir -p /pbuilder-results
DIST=lunar ARCH=i386 pbuilder create --distribution lunar --architecture i386 --debootstrapopts --include=ca-certificates
echo 'starting build'
DIST=lunar ARCH=i386 pbuilder build ./*.dsc --distribution lunar --architecture i386 --debootstrapopts --include=ca-certificates

# Move the debs to output
mkdir -p ./output
mv /var/cache/pbuilder/result/*.deb ./output/ || sudo mv ../*.deb ./output/