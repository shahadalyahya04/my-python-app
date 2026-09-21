#!/bin/bash
set -e

date
echo "Updating Python application on VM..."

APP_DIR="/home/azureuser/my-python-app"
BRANCH="main"

sudo git config --global --add safe.directory "$APP_DIR"

if [ ! -d "$APP_DIR/.git" ]; then
    echo "Repository not found at $APP_DIR"
    exit 1
fi

sudo -u azureuser bash -c "cd $APP_DIR && git pull origin $BRANCH"
sudo -u azureuser "$APP_DIR/venv/bin/pip" install --upgrade pip
sudo -u azureuser "$APP_DIR/venv/bin/pip" install -r "$APP_DIR/requirements.txt"
sudo systemctl restart myapp

echo "Python application update completed!"
