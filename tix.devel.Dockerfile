FROM tybcz/c7_rbenv_2.3.8:0.4.0

RUN yum -y install which
RUN yum -y install epel-release
RUN yum -y install nodejs

RUN mkdir /project
WORKDIR /project

COPY Gemfile /project/Gemfile
COPY Gemfile.lock /project/Gemfile.lock

#ENV LANG=en_US.UTF-8
#ENV LANGUAGE=en_US.UTF-8
#ENV LC_ALL=en_US.UTF-8

RUN bundle install
RUN gem install ruby-debug-ide --pre

CMD "/bin/bash"