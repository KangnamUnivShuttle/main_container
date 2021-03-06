FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install tmux htop vim curl -y

# Set timezone
ENV TZ Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN date

# Install nodejs 14
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install --force-yes -y nodejs
RUN node -v

# Install docker for DooD (Docker out of Docker)
# RUN apt-get install \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg \
#     lsb-release -y
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# RUN echo \
#   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install wget iptables libltdl7=2.4.2-1.7ubuntu1 libsystemd-journal0=204-5ubuntu20.31 -y
# RUN apt-get install docker-ce docker-ce-cli containerd.io -y
# RUN apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
RUN wget https://download.docker.com/linux/ubuntu/dists/trusty/pool/stable/amd64/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb
RUN dpkg --install ./docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb
# RUN groupadd -g 499 docker

# VOLUME ["/var/run/docker.sock"]

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN docker-compose --version

# Install pm2
RUN [ "npm", "install", "pm2@5.1.2", "-g" ]

# Open port
EXPOSE 3000/tcp

RUN apt-get install git -y

# Setup main_backend app
RUN mkdir -p /app
WORKDIR /app
# RUN mkdir -p /app/src
COPY ecosystem.config.js ./
COPY ./build/* ./
COPY ./build/src/* ./
RUN [ "npm", "i" ]
RUN ["npm", "run", "typeorm", "migration:run"]

# Setup jingisukan app
RUN [ "git", "clone", "https://github.com/KangnamUnivShuttle/jingisukan_cli.git", "/cli" ]
WORKDIR /cli
RUN [ "npm", "i" ]
RUN [ "npm", "run", "inst" ]

# Make dir for plugin
RUN mkdir -p /plugin

# Run pm2 runtime
WORKDIR /app
CMD [ "pm2-runtime", "start", "ecosystem.config.js", "--env", "production" ]