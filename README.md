Shellpaste is a service like pastebin but with curl an simple.  
beta now  

# Direct connection to service

### send file  
curl -X POST --data-binary @/home/daniel/config.txt http://vps260977.ovh.net:80  
### get file  
curl http://vps260977.ovh.net/p/TOKEN > file.txt

# script exemple (openssl + curl)  
``./shellpaste.sh -s /tmp/test.txt  
http://vps260977.ovh.net/p/xc5Zv9poQG
``

on the server  
``
 cat xc5Zv9poQG  
U2FsdGVkX1/lJlekNWS6WTxuEu0BhTHLU6aufS7KUQx5V6Lgs9mZJj0mPXWG6b/L
UfzA8kD8kKE=
``  

get the file  
``
./shellpaste.sh -g xc5Zv9poQG
``  
file save in myfile.txt


*thanks http://dillinger.io/ to write readme* 