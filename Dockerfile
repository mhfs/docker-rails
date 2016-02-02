FROM ruby:2.2.4

RUN apt-get update -qq && apt-get install -y git build-essential libpq-dev libxml2-dev libxslt1-dev nodejs && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install --without development test --deployment --jobs=4 --retry=3

ADD . $APP_HOME

RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=pickasecuretoken assets:precompile

VOLUME ["$APP_HOME/public"]

CMD bin/rails server --port 3000 --binding 0.0.0.0
