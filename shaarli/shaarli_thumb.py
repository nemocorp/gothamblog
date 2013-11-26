import urllib.request
from bs4 import BeautifulSoup
import sys
import subprocess 

url=urllib.request.urlopen('http://www.nemocorp.info/shaarli/index.php5')
soup=BeautifulSoup(url.read())

num_item = int(sys.argv[1])
permalinks = soup.select(".linkdate")
site_urls = soup.find_all('h3')

for i in range(num_item):
    permalink = permalinks[i].next_element.get('href')[1:] + ".png"
    site_url = site_urls[i].next_element.get('href')
    print('-'*40)
    print (permalink)
    print (site_url)
    print('-'*40)
    subprocess.Popen(["./shaarli_thumb.sh", permalink, site_url]).wait()


