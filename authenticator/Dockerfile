FROM ruby:2.6.5-alpine3.11

RUN addgroup --gid 1000 app && \
  adduser --uid 1000 --ingroup app --home /home/app --disabled-password app

RUN apk update && \
  apk upgrade && \
  apk add postgresql-client libpq postgresql-dev nodejs build-base tzdata yarn && \
  rm -rf /var/cache/apk/*

COPY ./Gemfile* package.json yarn.lock /srv/
RUN gem install bundler
WORKDIR /srv
RUN bundle install && yarn install

COPY . /srv/
RUN chown -R app:app /srv

USER app

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0"]
