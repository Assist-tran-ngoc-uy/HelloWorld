#!/bin/bash
set -euxo pipefail

APP_DIR="/var/www/html/HelloWorld"
BRANCH="main"
LOG_FILE="/tmp/helloworld-deploy.log"

exec > >(tee -a "${LOG_FILE}") 2>&1

echo "========== DEPLOY START =========="
date
whoami
pwd

echo "APP_DIR=${APP_DIR}"
echo "BRANCH=${BRANCH}"

if [ ! -d "${APP_DIR}/.git" ]; then
    echo "ERROR: ${APP_DIR} is not a Git repository"
    exit 1
fi

cd "${APP_DIR}"

echo "Remote:"
git remote -v

echo "Before pull:"
git log --oneline --decorate -5

echo "Fetch latest code"
git fetch origin "${BRANCH}"

echo "Reset working tree"
git reset --hard "origin/${BRANCH}"
git clean -fd

echo "After pull:"
git log --oneline --decorate -5

echo "Restart Docker"
docker compose down || true
docker compose up -d --build

echo "========== DEPLOY DONE =========="