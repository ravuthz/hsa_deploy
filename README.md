docker-compose -f docker-compose.prod.yml up -d --build


docker-compose -f docker-compose.yml up -d --build


docker-compose exec db psql --username=hello_django --dbname=hello_django_dev


```bash
# nginx -v
nginx version: nginx/1.14.0 (Ubuntu)

# psql --version
psql (PostgreSQL) 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

# python --version
Python 3.7.4

# pip --version
pip 19.3 from d:\apps\python37\lib\site-packages\pip (python 3.7)

# Ubuntu 18.04.3

pip install -r requirements.txt

python -m pip install --upgrade pip
```