# initialize environment variables
echo 'SECRET_KEY_BASE='$(rails secret) > .env

# build docker image
docker-compose build

# create and migrate database
docker-compose run web rake db:create db:migrate

# start application
docker-compose up
