FROM ruby:3.2-slim

WORKDIR /app

# Instalar dependências do sistema (exemplo para PostgreSQL)
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs libyaml-dev && \
    rm -rf /var/lib/apt/lists/*

# Copiar arquivos de dependências e instalar gems
COPY backend/Gemfile backend/Gemfile.lock ./
RUN bundle install

# Copiar o restante da aplicação
COPY backend ./

EXPOSE 3000

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
