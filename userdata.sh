 #! /bin/bash
    yum update -y
    yum -y install wget
    yum install httpd -y
    FOLDER=("https://raw.githubusercontent.com/bostantrt1/project-kitten/main/static-web")
    cd /var/www/html
    wget $FOLDER/index.html
    wget $FOLDER/cat0.jpg
    wget $FOLDER/cat1.jpg
    wget $FOLDER/cat2.jpg
    wget $FOLDER/cat3.png
    systemctl start httpd
    systemctl enable httpd
  
