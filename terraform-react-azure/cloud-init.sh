#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
export HOME=/root

# 1. Update system and install Node.js, npm, git
apt-get update -y
apt-get install -y nodejs npm git

# Small VMs can run out of memory during the React build, so add swap
if [ ! -f /swapfile ]; then
  fallocate -l 1G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
fi

# 2. Install and enable Nginx
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx

# 3. Clone the app
cd /opt
git clone https://github.com/pravinmishraaws/my-react-app.git
cd /opt/my-react-app

# Put your name and date in the app (change these two values)
sed -i 's/Your Full Name/AKUBUKO JAPHET UCHENNA/g' src/App.js
sed -i 's/DD\/MM\/YYYY/05\/10\/2026/g' src/App.js

# 4. Install dependencies and build
npm install
npm run build

# 5. Deploy build files to Nginx
rm -rf /var/www/html/*
cp -r build/* /var/www/html/
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# 6. Configure Nginx for React routing
cat > /etc/nginx/sites-available/default <<'EOF'
server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.html;

    location / {
        try_files $uri /index.html;
    }

    error_page 404 /index.html;
}
EOF

# 7. Test and restart Nginx
nginx -t
systemctl restart nginx
