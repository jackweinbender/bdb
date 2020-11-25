FROM ruby:2.7.2-slim

# Change me
ARG APP_NAME=bdb

# CORE RAILS DEPS
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    apt-transport-https \
    build-essential \
    ruby-dev \
    gnupg \
    curl \
    && rm -rf /var/lib/apt/lists/*

# YARN & NODE
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    #YARN
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y \
    nodejs \
    yarn \
    && rm -rf /var/lib/apt/lists/*

# POSTGRES DEPENDENCIES
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    postgresql-client \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

ENV BUNDLER_VERSION=2.1.4

RUN gem update --system && \
    gem install bundler:2.1.4

RUN mkdir /${APP_NAME}
WORKDIR /${APP_NAME}

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]