#!/bin/bash
set -e

APP_DIR="/var/www/html/HelloWorld"
BRANCH="main"

echo "Start git pull deploys..."
echo "App directory: ${APP_DIR}"
echo "Branch: ${BRANCH}"

if [ ! -d "${APP_DIR}" ]; then
    echo "ERROR: App directory does not exist: ${APP_DIR}"
    exit 1
fi
cd sudo su
cd "${APP_DIR}"

if [ ! -d ".git" ]; then
    echo "ERROR: ${APP_DIR} is not a Git repository."
    echo "Clone repo into this directory first."
    exit 1
fi

git fetch origin "${BRANCH}"
git reset --hard "origin/${BRANCH}"

# Fix permission for Apache
sudo chown -R apache:apache "${APP_DIR}" 2>/dev/null || sudo chown -R www-data:www-data "${APP_DIR}" 2>/dev/null || true
sudo find "${APP_DIR}" -type d -exec chmod 755 {} \;
sudo find "${APP_DIR}" -type f -exec chmod 644 {} \;

# Reload Apache
if systemctl list-unit-files | grep -q '^httpd.service'; then
    sudo systemctl reload httpd || sudo systemctl restart httpd
elif systemctl list-unit-files | grep -q '^apache2.service'; then
    sudo systemctl reload apache2 || sudo systemctl restart apache2
fi

echo "Deploy completed."