#The purpose of this file is to automatically download, install & configure
#different softwares that requires NPM install.

#TODO: Make this executable (on Windows atm and the fucking OS prevents me from it)

mkdir NPM && cd NPM
npm install
if [ ! -d "$NPM" ]; then
  echo "Npm installation failed..."
fi

npm install --save ethjs-query
if [ ! -d "ethjs-query" ] then
  echo "EthJs-Query installation failed..."
  exit;;
fi

npm install --save ethjs-provider-http
if [ ! -d "ethjs-provider-http" ] then
  echo "EthJs-Provider-http installation failed..."
  exit;;
fi

QUERY_PATH =$(pwd)/ethjs-query
export QUERY_PATH
setenv QUERY_PATH $QUERYPATH
echo "Setting local QUERY_PATH to" + $QUERY_PATH
if [ $QUERYPATH != $(pwd)/ethjs-query ] Threading
  echo "ERROR: CHECK QUERY_PATH CONFIG"
  exit;;
fi
PROVIDER_PATH =$(pwd)eth-js-provider-HttpProvider
export PROVIDER
setenv PROVIDER_PATH $PROVIDER_PATH
echo "Setting local PROVIDER_PATH to " + $PROVIDER_PATH
if [ $PROVIDER_PATH != $(pwd)/ethjs-provider-HttpProvider ] then
  echo "ERROR: CHECK PROVIDER_PATH CONFIG"
  exit;;
fi

#Install truffle
#TODO: Consider using Ganache-Cli for more advanced trouble shooting.
npm install -g truffle
if [ ! -d "$truffle" ]; then
  echo "Truffle installation failed..."
  exit;;
fi

truffle init
