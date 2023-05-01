
echo 'phase1'

mk-sbuild sid --arch=i386 --debootstrap-include=libeatmydata1 --debootstrap-mirror=http://cdn-fastly.deb.debian.org/debian
echo 'phase2'
sbuild -d sid-i386 ./*.dsc

# Move the debs to outputmkdir -p ./output
sudo mv ./*.deb ./output/
