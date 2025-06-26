---
name: Bug Report
about: Create a report to help us improve
title: '[BUG] '
labels: bug
assignees: ''
---

## 🐛 Bug Description

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Configure exporter with '...'
2. Start exporter with '...'
3. Query metrics at '...'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Actual behavior**
What actually happened instead.

## 📋 Environment

**RabbitMQ Exporter version:**
- Version: [e.g. v1.0.0]
- Commit: [e.g. abc1234]

**RabbitMQ:**
- Version: [e.g. 3.8.5]
- Management plugin enabled: [yes/no]

**Environment:**
- OS: [e.g. Ubuntu 20.04, macOS 11.0, Windows 10]
- Docker: [if applicable, include version]
- Kubernetes: [if applicable, include version]

**Configuration:**
```json
{
  "rabbit_url": "http://localhost:15672",
  "rabbit_user": "guest",
  "rabbit_password": "guest"
}
```

## 📊 Logs and Output

**Exporter logs:**
```
[paste exporter logs here]
```

**RabbitMQ logs (if relevant):**
```
[paste rabbitmq logs here]
```

**Prometheus scrape output (if relevant):**
```
[paste prometheus metrics or error output here]
```

## 📸 Screenshots

If applicable, add screenshots to help explain your problem.

## 🔍 Additional Context

Add any other context about the problem here.

**Workarounds:**
If you found any workarounds, please describe them here.

**Related issues:**
Link to any related issues or discussions.

## ✅ Checklist

- [ ] I have searched existing issues to ensure this is not a duplicate
- [ ] I have included all relevant configuration details
- [ ] I have included logs and error messages
- [ ] I have tested with the latest version
- [ ] I have provided steps to reproduce the issue
