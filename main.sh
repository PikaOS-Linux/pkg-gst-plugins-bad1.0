# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
touch /etc/apt/sources.list.d/pika.list
echo 'deb https://ppa.pika-os.com/ lunar main' > /etc/apt/sources.list.d/pika.list
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
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
