FROM tybcz/c7_rbenv_2.0.0:0.4.0

WORKDIR /project

COPY Gemfile /project/Gemfile
COPY Gemfile.lock /project/Gemfile.lock

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN bundle install

CMD "/bin/bash"