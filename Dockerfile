# Install node v10
FROM ubuntu:latest
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y  --no-install-recommends \
    build-essential \
    ca-certificates \
    gcc \
    git \
    libpq-dev \
    make \
    python-pip \
    python2.7 \
    python2.7-dev \
    apt-transport-https \
    curl \
    g++ \
    nginx \
    sudo \
    wget \
    bzip2 \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* \
    && apt-get -y autoclean

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.6.0

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Set up our PATH correctly so we don't have to long-reference npm, node, &c.
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Set nginx environment
COPY ./nginx/default.conf /etc/nginx/sites-enabled/default

# Set the workdir /var/www/myapp
WORKDIR /var/www/express-docker-test

# Copy the package.json to workdir
COPY package.json ./

RUN npm install -g nodemon

# Run npm install - install the npm dependencies
RUN npm install

# Copy application source
COPY . .

# Copy .env.docker to workdir/.env - use the docker env

# Expose application ports - (4300 - for API and 4301 - for front end)
EXPOSE 80
# RUN npm start
CMD ["nginx", "-g", "daemon off;"]

# Generate build
# RUN npm run build

# Start the application
# CMD ["npm", "start"]