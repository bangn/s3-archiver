FROM ruby:2.4.2-alpine

ENV APP_HOME /usr/share/s3-archiver
WORKDIR $APP_HOME

# Setup gems.
ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "-p", "9292"]
