sudo rm -rf /var/cache/apt/
DIST=sid ARCH=i386 pbuilder create --mirror http://deb.debian.org/debian --distribution sid --architecture i386
echo 'starting build'
DIST=sid ARCH=i386 pbuilder build ./*.dsc --mirror http://deb.debian.org/debian  --distribution sid --architecture i386

# Move the debs to outputmkdir -p ./output
sudo mv ./*.deb ./output/
