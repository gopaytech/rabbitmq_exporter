# GitHub Actions CI/CD Pipeline

This repository uses GitHub Actions for automated building, testing, and releasing of the RabbitMQ Exporter.

## Workflows

### 1. Release (`release.yml`)
**Trigger**: Push to any tag (e.g., `v1.0.0`)

**What it does**:
- Runs tests
- Builds multi-architecture binaries and Docker images
- Creates GitHub release with release notes
- Pushes Docker images to:
  - GitHub Container Registry (`ghcr.io/gopaytech/rabbitmq_exporter`)
  - Docker Hub (`gopaytech/rabbitmq-exporter`)
- Creates multi-platform Docker manifests

**Required secrets**:
- `GITHUB_TOKEN` (automatically provided)
- `DOCKERHUB_USERNAME` (optional, for Docker Hub publishing)
- `DOCKERHUB_TOKEN` (optional, for Docker Hub publishing)

### 2. Continuous Integration (`ci.yml`)
**Trigger**: Push to `main` branch

**What it does**:
- Runs tests and integration tests
- Builds and pushes development Docker images to GHCR
- Creates `latest` tag for main branch builds
- Uses GitHub Actions cache for faster builds

### 3. Pull Request (`pr.yml`)
**Trigger**: Pull requests to `main` branch

**What it does**:
- Runs tests and linting
- Validates GoReleaser configuration
- Runs GoReleaser in snapshot mode (without publishing)

### 4. Security (`security.yml`)
**Trigger**: Push to `main`, PRs, and weekly schedule

**What it does**:
- Runs Go vulnerability checks with `govulncheck`
- Scans Docker images for vulnerabilities with Trivy
- Uploads security scan results to GitHub Security tab

### 5. Cleanup (`cleanup.yml`)
**Trigger**: Weekly schedule and manual dispatch

**What it does**:
- Cleans up old container images (keeps 10 most recent)
- Removes old pre-releases (keeps 5 most recent)

## Container Images

### GitHub Container Registry
The primary container registry for this project:
```bash
# Latest release
docker pull ghcr.io/gopaytech/rabbitmq_exporter:latest
docker pull ghcr.io/gopaytech/rabbitmq_exporter:v1.0.0

# Development builds
docker pull ghcr.io/gopaytech/rabbitmq_exporter:main
```

### Docker Hub (Optional)
If Docker Hub credentials are configured:
```bash
# Latest release
docker pull gopaytech/rabbitmq-exporter:latest
docker pull gopaytech/rabbitmq-exporter:v1.0.0
```

## Supported Architectures

The container images are built for multiple architectures:
- `linux/amd64`
- `linux/arm64`
- `linux/arm/v6`
- `linux/arm/v7`

## Security Features

- **Vulnerability Scanning**: Automatic scanning with Trivy
- **Go Security**: Regular vulnerability checks with govulncheck
- **Minimal Attack Surface**: Uses distroless or minimal base images
- **SARIF Integration**: Security findings uploaded to GitHub Security tab

## Development Workflow

1. **Create a feature branch**
2. **Open a Pull Request** - Triggers testing and validation
3. **Merge to main** - Builds and pushes development images
4. **Create a tag** - Triggers full release process

## Manual Release Process

To create a new release:

1. Ensure all changes are merged to `main`
2. Create and push a new tag:
   ```bash
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```
3. The release workflow will automatically:
   - Build all artifacts
   - Create GitHub release
   - Push container images

## Configuration

### Required Repository Settings

1. **Actions permissions**: Allow GitHub Actions to create and approve pull requests
2. **Package permissions**: Allow GitHub Actions to write packages
3. **Security settings**: Enable Dependency graph and Dependabot alerts

### Optional Secrets

- `DOCKERHUB_USERNAME`: Your Docker Hub username
- `DOCKERHUB_TOKEN`: Docker Hub access token with push permissions

### Environment Variables

The workflows use these environment variables:
- `REGISTRY`: Set to `ghcr.io` for GitHub Container Registry
- `IMAGE_NAME`: Automatically set to repository name

## Troubleshooting

### Common Issues

1. **Container registry permission denied**
   - Ensure `packages: write` permission is set in workflow
   - Check that `GITHUB_TOKEN` has package permissions

2. **Docker Hub push fails**
   - Verify `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets are set
   - Check that Docker Hub token has push permissions

3. **GoReleaser fails**
   - Validate `.goreleaser.yml` configuration
   - Ensure all required environment variables are available

### Debugging

To debug workflows:
1. Check the Actions tab in GitHub repository
2. Review logs for failed steps
3. Use `workflow_dispatch` trigger for manual testing
4. Run GoReleaser locally: `goreleaser release --snapshot --clean --skip=publish`
