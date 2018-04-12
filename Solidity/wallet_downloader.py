import urllib2
import zipfile
import SilentRemover

"""
This script should be refactored so that URLs could be sent into it
and naturally downloaded and unzipped
"""

url = "https://github.com/ethereum/mist/releases/download/v0.10.0/Ethereum-Wallet-win32-0-10-0.zip"

file_name = url.split('/')[-1]
u = urllib2.urlopen(url)
f = open(file_name, 'wb')
meta = u.info()
file_size = int(meta.getheaders("Content-Length")[0])
print "Downloading: %s Bytes: %s" % (file_name, file_size)

file_size_dl = 0
block_sz = 8192
while True:
    buffer = u.read(block_sz)
    if not buffer:
        break

    file_size_dl += len(buffer)
    f.write(buffer)
    status = r"%10d  [%3.2f%%]" % (file_size_dl, file_size_dl * 100. / file_size)
    status = status + chr(8)*(len(status)+1)
    print status,

zip_ref = zipfile.ZipFile("./Ethereum-Wallet-win32-0-10-0.zip", 'r')
zip_ref.extractall("./")
zip_ref.close()

SilentRemover("./Ethereum-Wallet-win32-0-10-0.zip")
