#TODO:Make this file executable on Linux.
#This file will start deployment of Ethereums blockchain

echo "WARNING!"
echo ""
echo "Running this file will take several hours"
echo "and leave your computer laggy over during"
echo "the entire download process!"
echo ""
echo "Are you sure you wish to proceed?"
while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

geth --fast --cache=1024
make geth
