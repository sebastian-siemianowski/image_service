From ruby:2.5.0

# install required system packages for ruby, rubygems and webpack
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -qq -y --no-install-recommends apt-utils ca-certificates nodejs yarn \
  libicu-dev imagemagick unzip qt5-default libqt5webkit5-dev \
  gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
  xvfb xauth \
  git busybox build-essential

RUN busybox --install -s
ENV APP_HOME /usr/src
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
COPY vendor/ $APP_HOME/vendor/
# Everything else is mapped across in docker-compose.yml

RUN gem update bundler
RUN bundle install

# Its not generating the rspec.xml hence commenting it out
#RUN bundle exec rspec spec --format RspecJunitFormatter --out rspec.xml

ENTRYPOINT ["bundle", "exec", "rails"]
CMD ["server", "-b", "0.0.0.0"]
