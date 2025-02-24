# Simple script to ensure that docker is properly set up to be used without sudo

set -e
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world
