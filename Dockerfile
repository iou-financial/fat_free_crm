# Usage:
# docker volume create pgdata
# docker volume create gems
# docker-compose up
# docker-compose exec web bundle exec rake db:create db:schema:load ffcrm:demo:load
FROM nullstone/rails:ruby3.3-webapp

RUN apt-get update && \
	apt-get install -y imagemagick tzdata && \
	apt-get autoremove -y

WORKDIR /
COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

WORKDIR /app

COPY Gemfile* ./
RUN gem install bundler && \
	bundle config set --local deployment 'true' && \
	bundle install --deployment

COPY . .
