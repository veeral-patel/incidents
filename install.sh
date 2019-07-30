# initialize environment variables
secret=$(dd if=/dev/urandom count=1 bs=128 2> /dev/null | sha512sum | cut -d ' ' -f 1)
echo 'SECRET_KEY_BASE='$secret > .env

# to use the dark theme, replace with:
# sh ./choose_theme.sh dark
sh ./choose_theme.sh light

# build docker image
docker-compose build

# create and migrate database
docker-compose run web rake db:create db:migrate

# start application
docker-compose up -d
