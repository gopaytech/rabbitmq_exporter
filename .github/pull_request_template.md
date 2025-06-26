## 📝 Description

**What type of change does this PR introduce?**
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Performance improvement
- [ ] Test improvement

**Brief description of changes:**
[Provide a clear and concise description of what this PR does]

## 🔗 Related Issues

**Fixes:** #(issue_number)
**Related to:** #(issue_number)

## 🧪 Testing

**How has this been tested?**
- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual testing
- [ ] Tested with RabbitMQ version(s): 

**Test Configuration:**
- RabbitMQ version: 
- Exporter configuration used:
```json
{
  "test": "configuration"
}
```

**Test scenarios covered:**
- [ ] Normal operation
- [ ] Error conditions
- [ ] Edge cases
- [ ] Performance impact

## 📋 Checklist

**Before submitting:**
- [ ] I have read the [CONTRIBUTING.md](CONTRIBUTING.md) document
- [ ] My code follows the code style of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] Any dependent changes have been merged and published

**Documentation:**
- [ ] Updated README.md (if applicable)
- [ ] Updated configuration examples (if applicable)
- [ ] Updated metrics documentation (if applicable)
- [ ] Added/updated code comments

**Backwards Compatibility:**
- [ ] This change is backwards compatible
- [ ] This change includes migration instructions (if breaking)
- [ ] This change updates the version appropriately

## 📊 Metrics Impact

**New metrics added:**
```
# List any new metrics this PR introduces
example_metric_total{label="value"} 42
```

**Modified metrics:**
```
# List any existing metrics that are changed
modified_metric_total{new_label="value"} 42
```

**Deprecated metrics:**
```
# List any metrics that are deprecated by this PR
deprecated_metric_total{label="value"} 42
```

## 🚀 Performance Impact

**Expected performance impact:**
- [ ] No performance impact
- [ ] Minimal performance impact
- [ ] Significant performance improvement
- [ ] Potential performance degradation (explain below)

**Performance testing results:**
[Include any performance testing results, benchmarks, or profiling data]

## 📸 Screenshots

**Before:**
[Add screenshots showing the current behavior]

**After:**
[Add screenshots showing the new behavior]

## 🔍 Additional Notes

**Breaking changes:**
[List any breaking changes and migration steps]

**Dependencies:**
[List any new dependencies or dependency updates]

**Deployment considerations:**
[Any special considerations for deployment]

**Future work:**
[Any related work that should be done in the future]

## 🎯 Reviewer Focus Areas

**Please pay special attention to:**
- [ ] Error handling
- [ ] Memory leaks
- [ ] Goroutine management
- [ ] Configuration validation
- [ ] Metric accuracy
- [ ] Documentation clarity

**Questions for reviewers:**
1. [Specific question about implementation]
2. [Question about architectural decision]
3. [Question about testing approach]
