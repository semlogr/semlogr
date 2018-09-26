FROM ruby:2.3
LABEL maintainer="stefan.sedich@gmail.com"

# Switch to directory for build
WORKDIR /build

# Install codeclimate
RUN curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > "/usr/local/bin/cc-test-reporter" && \
    chmod +x "/usr/local/bin/cc-test-reporter"

# Copy files and install gems
COPY . .
RUN bundle install
