#!/bin/bash

# Local development and testing script for RabbitMQ Exporter
# This script helps with building, testing, and running the exporter locally

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    if ! command_exists go; then
        print_error "Go is not installed. Please install Go 1.22 or later."
        exit 1
    fi
    
    if ! command_exists docker; then
        print_error "Docker is not installed. Please install Docker."
        exit 1
    fi
    
    # Check Go version
    GO_VERSION=$(go version | awk '{print $3}' | sed 's/go//')
    print_status "Go version: $GO_VERSION"
    
    # Check Docker version
    DOCKER_VERSION=$(docker --version | awk '{print $3}' | sed 's/,//')
    print_status "Docker version: $DOCKER_VERSION"
}

# Run tests
run_tests() {
    print_status "Running tests..."
    go test -v ./...
    
    print_status "Running integration tests..."
    go test -v ./... -tags=integration || print_warning "Integration tests failed (this is expected if RabbitMQ is not available)"
}

# Build binary
build_binary() {
    print_status "Building binary..."
    go build -ldflags "-s -w -X main.Version=dev -X main.Revision=$(git rev-parse --short HEAD) -X main.Branch=$(git rev-parse --abbrev-ref HEAD) -X main.BuildDate=$(date -u +%Y-%m-%dT%H:%M:%SZ)" -o rabbitmq_exporter
    print_status "Binary built successfully: ./rabbitmq_exporter"
}

# Build Docker image
build_docker() {
    print_status "Building Docker image..."
    docker build -t gopaytech/rabbitmq-exporter:dev .
    print_status "Docker image built successfully: gopaytech/rabbitmq-exporter:dev"
}

# Run the exporter locally
run_local() {
    print_status "Running exporter locally..."
    print_warning "Make sure RabbitMQ is running and accessible"
    print_status "Starting exporter on http://localhost:9419"
    ./rabbitmq_exporter
}

# Run GoReleaser in snapshot mode
test_goreleaser() {
    if ! command_exists goreleaser; then
        print_error "GoReleaser is not installed. Please install it first:"
        echo "go install github.com/goreleaser/goreleaser@latest"
        exit 1
    fi
    
    print_status "Running GoReleaser in snapshot mode..."
    goreleaser release --snapshot --clean --skip=publish
}

# Clean up build artifacts
clean() {
    print_status "Cleaning up build artifacts..."
    rm -f rabbitmq_exporter
    rm -rf dist/
    docker rmi gopaytech/rabbitmq-exporter:dev 2>/dev/null || true
    print_status "Cleanup completed"
}

# Show help
show_help() {
    echo "RabbitMQ Exporter Development Script"
    echo ""
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  check        Check prerequisites"
    echo "  test         Run tests"
    echo "  build        Build binary"
    echo "  docker       Build Docker image"
    echo "  run          Run exporter locally (requires RabbitMQ)"
    echo "  release-test Test GoReleaser configuration"
    echo "  clean        Clean up build artifacts"
    echo "  all          Run check, test, build, and docker"
    echo "  help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 all          # Full build and test cycle"
    echo "  $0 test         # Run tests only"
    echo "  $0 docker       # Build Docker image only"
    echo "  $0 run          # Run locally (after build)"
}

# Main script logic
case "${1:-help}" in
    check)
        check_prerequisites
        ;;
    test)
        check_prerequisites
        run_tests
        ;;
    build)
        check_prerequisites
        build_binary
        ;;
    docker)
        check_prerequisites
        build_docker
        ;;
    run)
        if [ ! -f "./rabbitmq_exporter" ]; then
            print_error "Binary not found. Please run '$0 build' first."
            exit 1
        fi
        run_local
        ;;
    release-test)
        check_prerequisites
        test_goreleaser
        ;;
    clean)
        clean
        ;;
    all)
        check_prerequisites
        run_tests
        build_binary
        build_docker
        print_status "All tasks completed successfully!"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
