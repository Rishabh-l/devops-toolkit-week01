#!/usr/bin/env bash
set -euo pipefail

if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this deployment script using sudo!" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🚀 Starting Automated Deployment for Build 2..."
echo "📍 Project Root Directory resolved to: $SCRIPT_DIR"

echo "📦 Preparing and templating systemd unit profiles..."
sed "s|__REPO_DIR__|$SCRIPT_DIR|g" "$SCRIPT_DIR/systemd/myapp.service" > /etc/systemd/system/myapp.service
sed "s|__REPO_DIR__|$SCRIPT_DIR|g" "$SCRIPT_DIR/systemd/sysreport.service" > /etc/systemd/system/sysreport.service

if [ -f "$SCRIPT_DIR/systemd/sysreport.timer" ]; then
    cp "$SCRIPT_DIR/systemd/sysreport.timer" /etc/systemd/system/
fi

echo "🔄 Reloading systemd core engine configuration hooks..."
systemctl daemon-reload
systemctl enable --now myapp.service

echo "🔒 Generating local self-signed SSL Encryption Certificates..."
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/myapp.key -out /etc/ssl/certs/myapp.crt \
  -subj "/CN=localhost"

echo "🌐 Configuring Nginx Reverse Proxy routing records..."
cp "$SCRIPT_DIR/nginx/myapp.conf" /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

echo "🔄 Restarting web app layer processes..."
systemctl restart myapp.service
systemctl restart nginx

echo "================================================="
echo "🎉 PORTABLE DEPLOYMENT ENGINE EXECUTION COMPLETE!"
echo "Verify stack status: curl -k https://localhost/"
echo "================================================="
