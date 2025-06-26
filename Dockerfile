# Build stage: compile the Go application
FROM golang:1.21-alpine AS builder

# Install dependencies
RUN apk add --no-cache ca-certificates git

# Set working directory
WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build \
    -ldflags="-s -w -X main.Version=docker -X main.Revision=$(git rev-parse --short HEAD) -X main.Branch=$(git rev-parse --abbrev-ref HEAD) -X main.BuildDate=$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    -o rabbitmq_exporter .

# Final stage: the running container
FROM scratch AS final

# Add maintainer label
LABEL maintainer="gopaytech@gopay.com"

# Import the Certificate-Authority certificates for enabling HTTPS
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Import the compiled executable from the builder stage
COPY --from=builder /app/rabbitmq_exporter /rabbitmq_exporter

# Declare the port on which the webserver will be exposed.
# As we're going to run the executable as an unprivileged user, we can't bind
# to ports below 1024.
EXPOSE 9419

# Perform any further action as an unprivileged user.
USER 65535:65535

# Check if exporter is alive; 10 retries gives prometheus some time to retrieve bad data (5 minutes)
HEALTHCHECK --retries=10 CMD ["/rabbitmq_exporter", "-check-url", "http://localhost:9419/health"]

# Run the compiled binary.
ENTRYPOINT ["/rabbitmq_exporter"]
