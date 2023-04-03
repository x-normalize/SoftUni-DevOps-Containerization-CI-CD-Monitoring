#!/bin/bash

# Use node exporter (it works on Linux, macOS, and BSD) to monitor machines
# One can be downloaded from here https://prometheus.io/download/
# More information is available here https://github.com/prometheus/node_exporter 
# And more download artefacts, here https://github.com/prometheus/node_exporter/releases 
# For Windows based hosts go here https://github.com/prometheus-community/windows_exporter 

echo "### Downloading node exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz 

echo "### Extracting the downloaded node exporter..."
tar xzvf node_exporter-1.3.1.linux-amd64.tar.gz

echo "### Starting the node exporter (not in daemon mode)..."
cd node_exporter-1.3.1.linux-amd64/ && ./node_exporter &> /tmp/node-exporter.log &
