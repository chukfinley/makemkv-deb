echo "Installing apt packages"
sudo apt-get install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev git ffmpeg wget 
mkdir makemkv
cd makemkv
echo "Downloading Makemkv"
wget https://www.makemkv.com/download/makemkv-bin-1.17.5.tar.gz
wget https://www.makemkv.com/download/makemkv-oss-1.17.5.tar.gz
tar xvf makemkv-bin-1.17.5.tar.gz
tar xvf makemkv-oss-1.17.5.tar.gz
echo "Installing makemkv-oss"
cd makemkv-oss-1.17.5
sed -i "s/av_mallocz_array/av_calloc/g" libffabi/src/ffabi.c
./configure
make
sudo make install
cd ..
cd makemkv-bin-1.17.5
echo "Installing makemkv-bin"
make
sudo make install
echo "Cleaing up"
cd ../..
rm -rf makemkv

if which makemkv >/dev/null 2>&1; then
    echo "Installed successfully"
else
    echo "Installation Faild"
fi
echo "Done"

