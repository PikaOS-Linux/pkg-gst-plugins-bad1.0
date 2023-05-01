sudo apt install -y debian-archive-keyring
sudo rm -rf /var/cache/apt/
sudo ARCH=i386 pbuilder create --architecture i386
echo 'starting build'
sudo ARCH=i386 pbuilder build ./*.dsc --architecture i386

# Move the debs to outputmkdir -p ./output
sudo mv ./*.deb ./output/
