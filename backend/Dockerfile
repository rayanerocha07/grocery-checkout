FROM ruby:3.2-slim

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs libyaml-dev && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . ./

EXPOSE 3000

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
