
echo 'phase1'
touch ~/.sbuildrc
mk-sbuild lunar --arch=i386
echo 'phase2'
sbuild -d lunar-i386 ./*.dsc

# Move the debs to outputmkdir -p ./output
sudo mv ./*.deb ./output/
