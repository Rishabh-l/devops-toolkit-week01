#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this deployment script using sudo!"
  exit 1
fi

echo "🚀 Starting Automated Deployment for Build 2..."

echo "📦 Configuring myapp.service..."
cp ../systemd/myapp.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable --now myapp.service


echo "🔒 Generating SSL Certificates..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/myapp.key -out /etc/ssl/certs/myapp.crt \
  -subj "/CN=localhost"

echo "🌐 Configuring Nginx Site Config..."
cp ../nginx/myapp.conf /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

echo "🔄 Restarting services..."
systemctl restart myapp.service
systemctl restart nginx

echo "✨ Verifying deployment..."
nginx -t

echo "================================================="
echo "🎉 DEPLOYMENT COMPLETE!"
echo "Test your production app with: curl -k https://localhost/"
echo "================================================="

