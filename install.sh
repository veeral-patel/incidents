# initialize environment variables
secret=$(dd if=/dev/urandom count=1 bs=128 2> /dev/null | sha512sum | cut -d ' ' -f 1)
echo 'SECRET_KEY_BASE='$secret > .env
echo 'Initialized .env with contents:'
echo ""
cat .env
echo ""

if [ $# -eq 0 ]; then
    theme=light
elif [ $1 == 'light' ]; then
    theme="light"
elif [ $1 == 'dark' ]; then
    theme="dark"
else
    echo "ERROR: invalid theme -- must be either 'light' or 'dark'"
    echo ""
    echo "Usage:"
    echo "./install.sh # light theme"
    echo "./install.sh light # light theme"
    echo "./install.sh dark # dark theme"
    exit
fi
bash ./choose_theme.sh $theme

# build docker image
docker-compose build

# start application
docker-compose up -d

# create, migrate, seed database
docker-compose run web rake db:create db:migrate db:seed

# create initial user
docker-compose exec web rails runner /app/scripts/create_initial_user.rb

echo "Now visit http://localhost:80 and log in!"