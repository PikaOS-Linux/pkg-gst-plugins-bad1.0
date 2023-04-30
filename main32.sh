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

apt-get install -y pbuilder debootstrap devscripts debhelper sbuild debhelper ubuntu-dev-tools piuparts

cd ../

USERNAME=gitboi
USER_UID=1001
USER_GID=$USER_UID

CUR_DIR=$(pwd)
# Create the user
groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
groupadd sbuild
usermod -a -G sbuild gitboi
su $USERNAME -c ./sbuild32.sh
