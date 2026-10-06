#!/bin/bash
# Installs EpicBook prerequisites only. No passwords or secrets here.
export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get upgrade -y
apt-get install -y curl git nginx mysql-client ca-certificates

# Node.js LTS (22.x) and npm
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs

systemctl enable --now nginx
