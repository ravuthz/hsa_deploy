#!/bin/sh

BE_VENV=/home/hsa_user/django_hsa_venv
BE_PROJECT=/home/hsa_user/django_hsa

echo ""
echo "Deploy the BE (Django)"
echo ""

cd $BE_PROJECT

echo ""
echo "Checkout latest from remote master"
echo "============================================================================================"
git checkout .
git checkout master
git pull origin master

echo ""
echo "Active virtual evironment"
echo "============================================================================================"
source "${BE_VENV}/bin/activate"

echo ""
echo "Install all dependencies"
echo "============================================================================================"
pip install -r requirements.txt

echo ""
echo "Remigrate database"
echo "============================================================================================"
python manage.py makemigrations
python manage.py migrate

echo ""
echo "Dummpy course and address database"
echo "============================================================================================"
python dummy.py
python dummy_address.py

# sudo systemctl disable gunicorn.socket

# sudo systemctl stop gunicorn.socket
# sudo systemctl status gunicorn.socket

# sudo systemctl stop gunicorn.service
# sudo systemctl status gunicorn.service

echo ""
echo "Restart Unicorn Service"
echo "============================================================================================"
sudo systemctl start gunicorn.service
sudo systemctl status gunicorn.service
sudo systemctl start gunicorn.socket
sudo systemctl status gunicorn.socket
systemctl daemon-reload

echo ""
echo "Restart NGINX server"
echo "============================================================================================"
sudo service nginx restart