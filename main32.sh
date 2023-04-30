# Add dependent repositories
sudo dpkg --add-architecture i386
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
# Clone Upstream
wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gst-plugins-bad1.0/gst-plugins-bad1.0_1.22.1.orig.tar.xz
mkdir -p ./tar-arc
tar -xf ./gst-plugins-bad1.0_1.22.1-1ubuntu1.orig.tar.xz -C ./tar-arc/
mv ./tar-arc/* ./gst-plugins-bad1.0
cp -rvf ./debian ./gst-plugins-bad1.0/
cd ./gst-plugins-bad1.0

# Get build deps

apt-get install -y pbuilder debootstrap devscripts debhelper

# Build package
apt-get build-dep -y ./
debuild -S -uc -us
cd ../
ls
echo 'starting pbuilder'
DIST=lunar ARCH=i386 pbuilder create --distribution lunar --architecture i386
echo 'starting build'
DIST=lunar ARCH=i386 pbuilder build ./*.dsc --distribution lunar --architecture i386

# Move the debs to output
mkdir -p ./output
mv ./*.deb ./output/
