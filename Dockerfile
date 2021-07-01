FROM elasticsearch:7.10.1

ENV ES_HOME /usr/share/elasticsearch
WORKDIR ${ES_HOME}

RUN yes | ./bin/elasticsearch-plugin install --silent discovery-ec2
