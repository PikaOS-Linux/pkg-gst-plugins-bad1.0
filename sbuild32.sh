sudo apt install -y debian-archive-keyring
sudo rm -rf /var/cache/apt/
sudo DIST=sid ARCH=i386 MIRROR=http://deb.debian.org/debian pbuilder create --mirror http://deb.debian.org/debian --distribution sid --architecture i386 --keyring=/usr/share/keyrings/debian-archive-keyring.gpg
echo 'starting build'
sudo DIST=sid ARCH=i386 MIRROR=http://deb.debian.org/debian pbuilder build ./*.dsc --mirror http://deb.debian.org/debian  --distribution sid --architecture i386 --keyring=/usr/share/keyrings/debian-archive-keyring.gpg

# Move the debs to outputmkdir -p ./output
sudo mv ./*.deb ./output/
