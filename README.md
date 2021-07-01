# DevOpsLab2: Stack ELK

## Set Stack ELK (Elasticsearch, Logstash, FileBeat and Kibana) in one single-node installation

### Setting initial requirements

This DevOps Lab will require a virtual machine with 4GB memory and, at least, 10GB space to be executed.
That machine will be Ubuntu 18.04 (or similar Linux) with GIT, Docker and DockerCompose already installed.

### Project structure

```
.
└── docker-compose.yml
└── README.md
```

[_docker-compose.yml_](docker-compose.yml)

```yml
services:
  elasticsearch:
    image: elasticsearch:7.8.0 (or build directly with plugins)
    ...
  cerebro:
    image: lmenezes/cerebro
    ...
  logstash:
    image: logstash:7.8.0
    ...
  nginx:
    image: nginx:latest #just for testing purposes
    ...
  kibana:
    image: kibana:7.8.0
    ...
  filebeat:   
    image: filebeat:latest
    ...
```

This compose file will create a stack with the ELK main services: `elasticsearch`, `logstash` and `kibana`;
Additionally, the compose adds a filebeat as an example of an external source of information, the Cerebro tool which is used to make basic monitoring and operation over the Stack.

A NGINX server is also added just for testing purpose of the systems.

When the stack is been deployed, the docker-compose maps port the default ports for each service to the equivalent ports on the host in order to inspect easier the web interface of each service.

**IMPORTANT NOTICE**: Ports 9200, 9300, 9000, 5000, 5044, 9600, 5601 and 4000 on the host MUST NOT already in use.

## Deploy with docker-compose

```bash
$ docker-compose up -d
Creating network "ELK elastic" with driver "bridge"
Pulling elasticsearch...
Pulling logstash...
Pulling kibana...
Pulling cerebro...
Pulling filebeat...
Creating els ... done
Creating cerebro ... done
Creating logst ... done
Creating kib ... done
Creating nginx ... done
Creating filebeat ... done
$
```

## Expected result

If everything is OK, you must see three containers running and the port mapping as displayed below (notice container ID could be different):

```bash
$ docker ps
CONTAINER ID  IMAGE                 COMMAND                  CREATED         STATUS                 PORTS                                               NAMES
45e9b302d0f0  elasticsearch:7.8.0   "/tini -- /usr/local…"   12 seconds ago  Up 2 seconds (healthy) 0.0.0.0:47321->9200/tcp, 0.0.0.0:49156->9300/tcp    els
a4c4f0d0f048  cerebro:latest        "/usr/local/bin/dock…"   12 seconds ago  Up 2 seconds           0.0.0.0:9000->9000/tcp                              cerebro
164f0553ed54  logstash:7.8.0        "/usr/local/bin/dock…"   13 seconds ago  Up 1 seconds           0.0.0.0:5000->5000/tcp, 0.0.0.0:5044->5044/tcp, 0.0.0.0:9600->9600/tcp, 0.0.0.0:5000->5000/udp   logst
fd3f0b35b448  kibana:7.8.0          "/usr/local/bin/dumb…"   14 seconds ago  Up 2 seconds           0.0.0.0:5601->5601/tcp                               kib
e2f3bacd4f46  filebeat:latest        "/usr/local/bin/dock…"  12 seconds ago  Up 1 seconds           0.0.0.0:                                             filebeat
a4f767a4b3c2  nginx:latest          "/docker-entypoint…"     12 seconds ago  Up 1 seconds           0.0.0.0:4000->4000/tcp                               nginx
$ 
```

Then, you can verify each application using the below links in your local web browser:

* Elasticsearch: [`http://localhost:9200`](http://localhost:9200)
* Cerebro: [`http://localhost:9000`](http://localhost:9000)
* Logstash: [`http://localhost:9600`](http://localhost:9600)
* Kibana: [`http://localhost:5601`](http://localhost:5601)

Stop and remove the containers (add -v if data must be deleted)

```bash
$ docker-compose down -v
$
```
