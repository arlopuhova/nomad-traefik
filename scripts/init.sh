#! /bin/bash

export SERVER_IP=$(cat /vagrant/server_ip)
export NOMAD_ADDR="http://$SERVER_IP:4646"
