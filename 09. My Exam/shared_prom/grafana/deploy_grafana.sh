#!/bin/bash

echo "### Deploy grafana on port 3000"
docker volume create grafana
docker run -d -p 3000:3000 --name grafana --rm -v grafana:/var/lib/grafana grafana/grafana-oss

echo "### Grafana Deployed! Default credentials admin/admin"
