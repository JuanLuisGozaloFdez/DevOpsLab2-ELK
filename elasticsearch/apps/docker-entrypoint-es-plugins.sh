#!/bin/bash
# setting up prerequisites

# plugin install delete-by-query
plugin install discovery-ec2

exec /docker-entrypoint.sh elasticsearch
