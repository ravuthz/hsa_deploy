#!/bin/sh

FE_PATH=/var/www/home-school-academy.com/html
FE_PROJECT=/home/hsa_user/angular_hsa

echo ""
echo "Deploy the FE (Angular)"
echo ""
    
if [ -d "$FE_PATH" ]; then
    echo ""
    echo "Backup old directory ( ${FE_PATH} )"
    echo "============================================================================================"
    tar -zcvf "${FE_PATH}-$(date '+%Y-%m-%d-%H-%M-%S').tar.gz" $FE_PATH
    ls $FE_PATH

    echo ""
    echo "Delete old directory ( ${FE_PATH} )"
    echo "============================================================================================"
    rm -rf $FE_PATH
else
    echo "The directory ( ${FE_PATH} ) doesn't exists"
    echo "============================================================================================"
fi

echo ""
echo "Pull new code from git to directory ( ${FE_PROJECT} )"
echo "============================================================================================"
cd $FE_PROJECT
git checkout .
git checkout master
git pull origin master

if [ ! -d "$FE_PATH" ]; then
    mkdir $FE_PATH
fi

echo ""
echo "Copy ${FE_PROJECT}/dist to $FE_PATH"
echo "============================================================================================"
cp -r ${FE_PROJECT}/dist/* $FE_PATH

echo ""
echo "Restart NGINX server"
echo "============================================================================================"
sudo service nginx restart
sudo service nginx status
exit 1