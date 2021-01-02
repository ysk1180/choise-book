# 参考にしたサイト：https://docs.docker.com/compose/rails/, https://qiita.com/at-946/items/c69a512ea47941747b18

FROM ruby:2.7.1-alpine3.12
RUN apk update && \
    apk upgrade && \
    apk add --no-cache linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql && \
    apk add --virtual build-packages --no-cache build-base curl-dev
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
# Gemfileをいじってないときはキャッシュを使うために、Gemfileを先にコピーしてbundle installしてる
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]