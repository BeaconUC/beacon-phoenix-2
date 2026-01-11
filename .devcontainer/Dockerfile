FROM elixir:1.19

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    nodejs \
    npm \
    vim \
    inotify-tools \
    postgresql-client

# Set up project folder
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install Hex and Rebar3
RUN mix local.hex --force && mix local.rebar --force && mix archive.install hex phx_new --force

EXPOSE 4000