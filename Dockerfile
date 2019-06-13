FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN gem install bundler
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

ENV RAILS_ENV=production
RUN rails assets:precompile
