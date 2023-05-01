
echo 'phase1'
touch ~/.sbuildrc
mk-sbuild sid --arch=i386 --debootstrap-include=libeatmydata1
echo 'phase2'
sbuild -d sid-i386 ./*.dsc

# Move the debs to outputmkdir -p ./output
sudo mv ./*.deb ./output/
