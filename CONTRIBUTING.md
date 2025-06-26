# Contributing to RabbitMQ Exporter

Thank you for your interest in contributing to the RabbitMQ Exporter! This document provides guidelines and information for contributors.

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Code Style](#code-style)
- [Release Process](#release-process)

## 🚀 Getting Started

### Prerequisites

- Go 1.21 or later
- Docker (for containerized testing)
- Git
- GoReleaser (for release testing)

### Development Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/rabbitmq_exporter.git
   cd rabbitmq_exporter
   ```

2. **Set up development environment**
   ```bash
   # Make development script executable
   chmod +x dev.sh
   
   # Check prerequisites and run full test suite
   ./dev.sh all
   ```

3. **Install GoReleaser (optional, for release testing)**
   ```bash
   go install github.com/goreleaser/goreleaser@latest
   ```

## 🛠 Development Setup

### Using the Development Script

We provide a convenient `dev.sh` script for common development tasks:

```bash
# Full development cycle
./dev.sh all

# Individual commands
./dev.sh check         # Check prerequisites
./dev.sh test          # Run tests
./dev.sh build         # Build binary
./dev.sh docker        # Build Docker image
./dev.sh run           # Run locally
./dev.sh release-test  # Test GoReleaser config
./dev.sh clean         # Clean up artifacts
```

### Manual Setup

```bash
# Install dependencies
go mod tidy

# Run tests
go test -v ./...

# Build
go build -o rabbitmq_exporter

# Run locally (requires RabbitMQ)
export RABBIT_URL="http://localhost:15672"
export RABBIT_USER="guest"
export RABBIT_PASSWORD="guest"
./rabbitmq_exporter
```

## 🔄 Making Changes

### Branch Naming

- Feature branches: `feature/description`
- Bug fixes: `fix/description`
- Documentation: `docs/description`

### Commit Messages

Follow conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build/maintenance tasks

Examples:
```
feat(exporter): add support for federation metrics
fix(connection): handle connection timeouts gracefully
docs(readme): update installation instructions
```

## 🧪 Testing

### Running Tests

```bash
# Unit tests
go test -v ./...

# Integration tests (requires RabbitMQ)
go test -v ./... -tags=integration

# Using development script
./dev.sh test
```

### Test Coverage

We aim for good test coverage. When adding new features:

1. Write unit tests for new functions/methods
2. Add integration tests for new endpoints
3. Test error conditions and edge cases

### Testing with Docker

```bash
# Build test image
./dev.sh docker

# Run with test RabbitMQ instance
docker-compose up -d rabbitmq
docker-compose up exporter
```

## 📝 Submitting Changes

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Write code following our style guidelines
   - Add/update tests as needed
   - Update documentation if required

3. **Test thoroughly**
   ```bash
   ./dev.sh all
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: your feature description"
   ```

5. **Push and create PR**
   ```bash
   git push origin feature/your-feature-name
   ```

### PR Requirements

Your pull request should:
- [ ] Pass all CI checks
- [ ] Include tests for new functionality
- [ ] Update documentation if needed
- [ ] Follow code style guidelines
- [ ] Have a clear description of changes
- [ ] Reference any related issues

### PR Template

When creating a PR, please include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
```

## 🎨 Code Style

### Go Standards

- Follow [Effective Go](https://golang.org/doc/effective_go.html)
- Use `gofmt` for formatting
- Use `golint` for linting
- Follow Go naming conventions

### Specific Guidelines

1. **Variable naming**: Use descriptive names
   ```go
   // Good
   rabbitConnection := &Connection{}
   
   // Bad
   conn := &Connection{}
   ```

2. **Error handling**: Always handle errors
   ```go
   // Good
   data, err := fetchData()
   if err != nil {
       return fmt.Errorf("failed to fetch data: %w", err)
   }
   
   // Bad
   data, _ := fetchData()
   ```

3. **Comments**: Document exported functions
   ```go
   // ExportMetrics collects and exports RabbitMQ metrics to Prometheus
   func ExportMetrics() error {
       // implementation
   }
   ```

### Linting

We use `golangci-lint` for comprehensive linting:

```bash
# Install
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Run
golangci-lint run
```

## 🚢 Release Process

### Versioning

We follow [Semantic Versioning](https://semver.org/):
- `MAJOR.MINOR.PATCH`
- Major: Breaking changes
- Minor: New features (backward compatible)
- Patch: Bug fixes (backward compatible)

### Creating a Release

1. **Update version** in relevant files
2. **Create and push tag**
   ```bash
   git tag -a v1.2.3 -m "Release v1.2.3"
   git push origin v1.2.3
   ```
3. **GitHub Actions** will automatically:
   - Build multi-architecture binaries
   - Create Docker images
   - Publish to GitHub Container Registry
   - Create GitHub release with changelog

### Pre-release Testing

Before creating a tag:

```bash
# Test GoReleaser configuration
./dev.sh release-test

# Or manually
goreleaser release --snapshot --clean --skip=publish
```

## 🤝 Community Guidelines

### Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help newcomers get started
- Report inappropriate behavior

### Getting Help

- **Issues**: Report bugs or request features
- **Discussions**: Ask questions or share ideas
- **Security**: Report security issues privately

### Recognition

Contributors are recognized in:
- Release notes
- Contributors section
- Special mentions for significant contributions

## 📚 Additional Resources

- [Go Documentation](https://golang.org/doc/)
- [Prometheus Documentation](https://prometheus.io/docs/)
- [RabbitMQ Management API](https://www.rabbitmq.com/management.html)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🎉 Thank You!

Every contribution, no matter how small, helps improve this project. Thank you for taking the time to contribute!
