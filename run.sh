#!/bin/bash

# Exit on error
set -e

# Load environment variables if .env exists
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

run_local() {
    echo "🚀 Starting application locally..."
    
    # Check if python is installed
    if ! command -v python &> /dev/null; then
        echo "❌ Error: python3 could not be found. Please install Python."
        exit 1
    fi

    # Set up virtual environment if it doesn't exist
    if [ ! -d "venv" ]; then
        echo "📦 Creating virtual environment..."
        python -m venv venv
    fi

    # Activate virtual environment
    # Handling both Windows (Git Bash) and Unix paths
    if [ -f "venv/Scripts/activate" ]; then
        source venv/Scripts/activate
    else
        source venv/bin/activate
    fi

    echo "⚙️  Installing requirements..."
    pip install -q -r requirements.txt

    echo "🎮 Running main.py..."
    python main.py
}

run_docker() {
    echo "🐳 Starting application in Docker..."
    
    # Check if docker is installed
    if ! command -v docker &> /dev/null; then
        echo "❌ Error: docker could not be found. Please install Docker."
        exit 1
    fi

    echo "🔨 Building and starting containers..."
    docker compose up -d

    echo "⏳ Waiting for services to stabilize..."
    sleep 3

    echo "✅ Containers are running."
    echo "📝 To see the app output and interact with it, run: docker attach restaurant-app"
    echo "-------------------------------------------------------------------"
    
    # Automatically attach if it's the only thing requested
    docker attach restaurant-app
}

show_help() {
    echo "Usage: $0 [local|docker]"
    echo ""
    echo "Commands:"
    echo "  local   - Runs the application on your host machine (requires Python)"
    echo "  docker  - Runs everything inside Docker containers"
    echo ""
}

# Main CLI logic
case "$1" in
    local)
        run_local
        ;;
    docker)
        run_docker
        ;;
    *)
        show_help
        exit 1
        ;;
esac
