FROM ruby:3.1-alpine

# libxml2-dev and libxslt-dev for nokogiri compiling
RUN apk add --update --no-cache \
  build-base \
  tzdata \
  libxml2-dev libxslt-dev

ARG app=/web_app
WORKDIR $app

COPY Gemfile Gemfile.lock .

RUN bundle config set --local force_ruby_platform true && \
    bundle config set --local build.nokogiri "--use-system-libraries" && \
    bundle install --jobs 4 --retry 3

COPY . /web_app

ENV RAILS_SERVE_STATIC_FILES=true
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
