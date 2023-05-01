sudo apt install -y debian-archive-keyring
sudo rm -rf /var/cache/apt/
sudo mkdir -p /pbuilder-results
sudo ARCH=i386 pbuilder create --mirror http://http.us.debian.org/debian --distribution sid --architecture i386
echo 'starting build'
sudo ARCH=i386 pbuilder build ./*.dsc --mirror http://http.us.debian.org/debian --distribution sid --architecture i386

# Move the debs to output
sudo mkdir -p ./output
sudo mv /var/cache/pbuilder/result/*.deb ./output/ || sudo mv ../*.deb ./output/
