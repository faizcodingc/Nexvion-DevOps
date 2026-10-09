#!/bin/bash

set -e

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

case "${1:-}" in
    start)
        docker compose up -d --build
        echo "Nexvion application started."
        ;;

    stop)
        docker compose down
        echo "Nexvion application stopped."
        ;;

    restart)
        docker compose down
        docker compose up -d --build
        echo "Nexvion application restarted."
        ;;

    status)
        docker compose ps
        ;;

    health)
        if curl -fsS http://localhost:8082/ > /dev/null; then
            echo "Nexvion application is healthy."
        else
            echo "Nexvion application health check failed."
            exit 1
        fi
        ;;

    *)
        echo "Usage: $0 {start|stop|restart|status|health}"
        exit 1
        ;;
esac
