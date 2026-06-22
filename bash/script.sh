#!/bin/bash
set -e

APP_DIR="/var/www/html/HelloWorld"
BRANCH="main"

echo "Start git pull deploys2..."
echo "App directory: ${APP_DIR}"
echo "Branch: ${BRANCH}"

if [ ! -d "${APP_DIR}" ]; then
    echo "ERROR: App directory does not exist: ${APP_DIR}"
    exit 1
fi
cd "${APP_DIR}"

if [ ! -d ".git" ]; then
    echo "ERROR: ${APP_DIR} is not a Git repository."
    echo "Clone repo into this directory first."
    exit 1
fi

git pull origin "${BRANCH}"

echo "Deploy completed."