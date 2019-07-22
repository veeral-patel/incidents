# initialize environment variables
secret=$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM
echo 'SECRET_KEY_BASE='$secret > .env

# build docker image
docker-compose build

# create and migrate database
docker-compose run web rake db:create db:migrate

# start application
docker-compose up
