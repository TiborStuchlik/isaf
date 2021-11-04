FROM tybcz/c7_rbenv_2.3.8

RUN yum -y install which
RUN yum -y install epel-release
RUN yum -y install nodejs

RUN mkdir -p /shared
RUN mkdir -p ~/.ssh; chmod 0700 ~/.ssh

WORKDIR /
COPY  all/.ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
COPY all/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
RUN ssh-keyscan -t rsa 172.17.0.1 >> ~/.ssh/known_hosts

RUN git clone --branch 4.0.0 root@172.17.0.1:/home/tibor/projects/shared/repositories/isaf.git /project

WORKDIR /project

COPY /tix/resources/environments/staging.rb config/environments/production.rb
COPY /tix/resources/database.yml config/database.yml
COPY /tix/resources/init.yml init.yml

#ENV LANG=en_US.UTF-8
#ENV LANGUAGE=en_US.UTF-8
#ENV LC_ALL=en_US.UTF-8

RUN bundle install
RUN rake symlinks:do

EXPOSE 3000