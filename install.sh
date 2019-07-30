# initialize environment variables
secret=$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM
echo 'SECRET_KEY_BASE='$secret > .env

# to use the dark theme, replace with:
# sh choose_script.sh dark
sh choose_script.sh light

# build docker image
docker-compose build

# create and migrate database
docker-compose run web rake db:create db:migrate

# start application
docker-compose up -d
