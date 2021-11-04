FROM tybcz/c7_rbenv_3.0.2:0.4.0

RUN yum -y install which

RUN mkdir -p /shared
RUN mkdir -p ~/.ssh; chmod 0700 ~/.ssh

WORKDIR /
COPY  all/.ssh/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa
COPY all/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
RUN ssh-keyscan -t rsa 172.17.0.1 >> ~/.ssh/known_hosts

RUN git clone --branch 4.0.0 root@172.17.0.1:/home/tibor/projects/shared/repositories/web_pa.git /project

WORKDIR /project

COPY /web_pa/resources/environments/staging.rb config/environments/production.rb
COPY /web_pa/resources/database.yml config/database.yml

RUN gem install debase -v 0.2.4.1
RUN gem install ruby-debug-ide

RUN bundle install
#RUN rake symlinks:do

EXPOSE 3000