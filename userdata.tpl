#!/bin/bash

####################### Install Apache Web Server #######################
yum install httpd -y

echo "
<html>
<title>remoteX</title>
<h2>
Web server launch time: $(date)<br>
</h2>
<h3>
This Web server is running in AWS ${region} region.
</h3>
" > /var/www/html/index.html

service httpd start