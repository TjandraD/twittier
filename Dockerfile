FROM ruby:3.0.1

RUN mkdir app

WORKDIR /app

COPY . .

RUN gem install bundler:2.2.21 --no-document

RUN bundle install

EXPOSE 4567

CMD ["ruby", "main.rb"]
