FROM tybcz/c7_rbenv_2.0.0:0.4.0

#RUN mkdir -p /project
RUN mkdir -p /shared
RUN mkdir -p ~/.ssh; chmod 0700 ~/.ssh

WORKDIR /
COPY  all/.ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
COPY all/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
RUN ssh-keyscan -t rsa 172.17.0.1 >> ~/.ssh/known_hosts

RUN git clone --branch 2.1.3 root@172.17.0.1:/home/tibor/projects/shared/repositories/kopr.git /project

WORKDIR /project

RUN bundle install
RUN rake symlinks:do

COPY /kopr/resources/environments/staging.rb config/environments/production.rb
COPY /kopr/resources/database.yml config/database.yml

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN bundle install

EXPOSE 3000