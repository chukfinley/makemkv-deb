PKGS="build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev git ffmpeg wget checkinstall"
missing=()
for p in $PKGS; do
    dpkg-query -W -f='${Status}' "$p" 2>/dev/null | grep -q "install ok installed" || missing+=("$p")
done
if [ ${#missing[@]} -gt 0 ]; then
    echo "Installing missing apt packages: ${missing[*]}"
    sudo apt-get install -y "${missing[@]}"
else
    echo "All apt packages already installed"
fi
mkdir makemkv
cd makemkv
echo "Downloading Makemkv"
wget https://www.makemkv.com/download/makemkv-bin-1.17.6.tar.gz
wget https://www.makemkv.com/download/makemkv-oss-1.17.6.tar.gz
tar xvf makemkv-bin-1.17.6.tar.gz
tar xvf makemkv-oss-1.17.6.tar.gz
echo "Installing makemkv-oss"
cd makemkv-oss-1.17.6
sed -i "s/av_mallocz_array/av_calloc/g" libffabi/src/ffabi.c
./configure
make
sudo checkinstall
cd ..
cd makemkv-bin-1.17.6
echo "Installing makemkv-bin"
make
sudo checkinstall
echo "Cleaing up"
cd ../..
rm -rf makemkv

if which makemkv >/dev/null 2>&1; then
    echo "Installed successfully"
else
    echo "Installation Faild"
fi
echo "Done"
