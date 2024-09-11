# Usage:
# docker volume create pgdata
# docker volume create gems
# docker-compose up
# docker-compose exec web bundle exec rake db:create db:schema:load ffcrm:demo:load
FROM nullstone/rails:ruby3.3-webapp

RUN apk add --no-cache --update \
	imagemagick \
  tzdata

WORKDIR /
COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

WORKDIR /rails

COPY Gemfile* ./
RUN gem install bundler
RUN bundle install

COPY . .
