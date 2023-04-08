 #!/bin/bash
 
 echo "### Deploying Grafana...."
 docker-compose -f docker-compose.yaml down || true
 docker-compose build --no-cache && docker-compose -f docker-compose.yaml up -d
