FROM bitwalker/alpine-elixir-phoenix

MAINTAINER Muneeb Baderoen <mbaderoen@gmail.com>

WORKDIR /app
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
RUN npm install -g yarn

COPY . ./

WORKDIR /app/assets
RUN yarn

WORKDIR /app
RUN pwd
