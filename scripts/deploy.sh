#!/bin/bash
set -e

# Multi-Environment Deploy Script
# Default to production if not specified
DEPLOY_ENV=${DEPLOY_ENV:-production}

echo "====================================="
echo "DevOps Simulator - Deployment"
echo "====================================="

# Pre-deployment checks (Shared Logic - kept outside conditional blocks)
echo "Running pre-deployment checks..."
if [ ! -f "config/app-config.yaml" ]; then
    echo "Error: Configuration file not found!"
    exit 1
fi

if [ "$DEPLOY_ENV" = "production" ]; then
    # Production configuration settings from HEAD
    echo "Mode: Production (Rolling Update)"
    DEPLOY_REGION="us-east-1"
    APP_PORT=8080

    echo "Environment: $DEPLOY_ENV"
    echo "Region: $DEPLOY_REGION"
    echo "Port: $APP_PORT"

    # Production deployment steps from HEAD
    echo "Starting production deployment..."
    echo "Pulling latest Docker images..."
    # docker pull devops-simulator:latest

    echo "Rolling update strategy initiated..."
    # kubectl rolling-update devops-simulator

    echo "Application available at: https://app.example.com"
    
elif [ "$DEPLOY_ENV" = "development" ]; then
    # Development configuration settings from dev
    echo "Mode: Development (Docker Compose)"
    DEPLOY_MODE="docker-compose"
    APP_PORT=3000
    ENABLE_DEBUG=true

    echo "Environment: $DEPLOY_ENV"
    echo "Mode: $DEPLOY_MODE"
    echo "Port: $APP_PORT"
    echo "Debug: $ENABLE_DEBUG"

    # Development deployment steps from dev
    echo "Installing dependencies..."
    npm install

    echo "Running tests..."
    npm test
    
    echo "Starting development deployment..."
    echo "Using Docker Compose..."
    docker-compose up -d

    echo "Waiting for application to be ready..."
    sleep 5

    echo "Performing health check..."
    curl -f http://localhost:$APP_PORT/health || exit 1

    echo "Hot reload enabled - code changes will auto-refresh"
    
else
    echo "Error: Unknown environment $DEPLOY_ENV"
    exit 1
fi

echo "Deployment completed successfully!"