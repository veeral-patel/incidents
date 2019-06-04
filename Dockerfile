FROM ruby:2.6.1-stretch

# Change to the application's directory
WORKDIR /application

# Set Rails environment to production
ENV RAILS_ENV production

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev --fix-missing --no-install-recommends

# Install gems, nodejs and precompile the assets
RUN gem install bundler

COPY Gemfile* ./
RUN bundle install --deployment --without development test

# Copy application code
COPY . /application/

# Start the server
RUN bundle exec rails server
