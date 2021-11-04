FROM tybcz/c7_rbenv_3.0.2:0.4.0

RUN mkdir /project
WORKDIR /project

COPY Gemfile /project/Gemfile
COPY Gemfile.lock /project/Gemfile.lock

RUN gem install debase -v 0.2.4.1
RUN gem install ruby-debug-ide

RUN bundle install

CMD "/bin/bash"