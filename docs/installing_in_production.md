# Installing INCIDENTS in Production

When running INCIDENTS in production, you want SSL and you want your files
and data to be stored reliably. This page shows you one (and soon a couple) ways how.

## Heroku (free)

Install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#download-and-install) before beginning.

First clone the Git repo:

```
git clone https://github.com/veeral-patel/incidents && cd incidents
```

Then create an Heroku app and push INCIDENTS to Heroku.
Heroku will automatically attach a database to the application for you,
no configuration required.

```
heroku create
git push heroku master
```

Migrate and seed the database (with the default statuses and priorities):

```
heroku run rails db:migrate db:seed
```

Run this script to create your initial (admin) user. Be sure to write
down the credentials that the script prints out!

```
heroku run rails runner ./scripts/create_initial_user.rb
```

Now we need to set some environment variables.

Run `heroku open` and replace `my-heroku-app-domain` below with the domain name of your Heroku app.
Something like this: `rainy-forest-33033.herokuapp.com`. Do **not** include the `http`/`https`!

```
heroku config:set RAILS_ENV=heroku
heroku config:set HOST_DOMAIN=my-heroku-app-domain
```

Now, sign up for [Digital Ocean](https://digitalocean.com) -- they have promo codes for new users -- and
create a Digital Ocean space. This is where we'll store the attachments users upload to tickets.

See [these instructions](https://fedible.org/2017/11/26/integrate-activestorage-with-digitalocean-spaces.html) or [create a GitHub issue](https://github.com/veeral-patel/incidents/issues/) if you need help; I'll reply in 1 day max.

```
heroku config:set DO_BUCKET=my-bucket-name
heroku config:set DO_ENDPOINT=https://my-region.digitaloceanspaces.com
heroku config:set DO_REGION=my-region
heroku config:set DO_ACCESS_KEY_ID=my-access-key-id
heroku config:set DO_SECRET_ACCESS_KEY=my-secret-access-key
```

You're almost done! Create a SendGrid account (you can use the free tier).

We need Sendgrid to deliver emails, which are sent if you forget your password, someone
mentions you, you're invited to join an INCIDENTS instance, and more.

[Create an API key that allows for sending email](https://sendgrid.com/docs/ui/account-and-settings/api-keys/), then run:

```
heroku config:set SENDGRID_API_KEY=my-sendgrid-api-key
```

Run `heroku open` to open your application and log in with the credentials you saved
from earlier.

Note: Remember that Heroku free tier dynos take 30 seconds to boot and have limited CPU/memory
and Heroku free tier databases only store up to 10,000 rows. Consider upgrading!
