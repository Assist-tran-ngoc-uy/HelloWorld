#!/bin/bash
set -e

APP_DIR="/var/www/html/HelloWorld"
BRANCH="main"
LOG_FILE="/tmp/helloworld-deploy.log"

exec > >(tee -a "${LOG_FILE}") 2>&1

echo "========== DEPLOY START =========="
date
echo "User: $(whoami)"
echo "App dir: ${APP_DIR}"
echo "Branch: ${BRANCH}"

if [ ! -d "${APP_DIR}" ]; then
    echo "ERROR: App directory does not exist: ${APP_DIR}"
    exit 1
fi

cd "${APP_DIR}"

if [ ! -d ".git" ]; then
    echo "ERROR: ${APP_DIR} is not a Git repository"
    exit 1
fi

echo "Remote:"
git remote -v

echo "Before pull:"
git log --oneline --decorate -3 || true

echo "Pull latest code..."
git fetch origin "${BRANCH}"
git reset --hard "origin/${BRANCH}"

echo "After pull:"
git log --oneline --decorate -3

echo "DEPLOY SUCCESS: code pulled successfully."
echo "========== DEPLOY DONE =========="