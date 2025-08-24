# Contributing to Ride-Sharing Backend

Thank you for your interest in contributing to this project! This guide will help you get started.

## 🚀 Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/ride-sharing-backend.git
   cd ride-sharing-backend
   ```
3. **Install** dependencies:
   ```bash
   npm install
   ```
4. **Set up** environment:
   ```bash
   cp .env.example .env
   # Configure your database connections
   ```

## 🛠️ Development Workflow

### Making Changes

1. **Create a new branch** for your feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following our coding standards

3. **Test your changes**:
   ```bash
   npm test
   npm run test:integration
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request** on GitHub

### Commit Message Format

We use [Conventional Commits](https://conventionalcommits.org/) format:

```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```bash
feat(auth): add JWT token refresh mechanism
fix(orders): resolve driver assignment race condition
docs(api): update endpoint documentation
```

## 🧪 Testing

### Running Tests

```bash
# Unit tests
npm test

# Integration tests
npm run test:integration

# Test coverage
npm run test:coverage

# Linting
npm run lint
```

### Writing Tests

- Write tests for new features and bug fixes
- Follow the existing test patterns
- Aim for high test coverage (80%+)
- Test both success and error scenarios

## 📝 Code Style

### JavaScript/Node.js Guidelines

- Use **ES6+** features
- Follow **camelCase** for variables and functions
- Use **PascalCase** for classes and constructors
- Add **JSDoc** comments for complex functions
- Keep functions small and focused (max 20 lines)
- Use **async/await** instead of callbacks

### File Organization

- Models in `src/models/`
- Routes in `src/routes/`
- Controllers in `src/controllers/`
- Services in `src/services/`
- Middleware in `src/middleware/`
- Utilities in `src/utils/`

### Error Handling

- Use the centralized error handler
- Create custom error classes when needed
- Always validate input data
- Log errors appropriately

## 📋 Pull Request Guidelines

### Before Submitting

- [ ] Code follows project style guidelines
- [ ] Tests pass locally
- [ ] New features have corresponding tests
- [ ] Documentation is updated if needed
- [ ] Commit messages follow conventional format

### PR Description Template

```markdown
## What does this PR do?
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tests pass
- [ ] New tests added
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or marked as such)
```

## 🐛 Reporting Issues

### Bug Reports

Please include:
- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Environment details (Node.js version, OS, etc.)
- Relevant logs or error messages

### Feature Requests

Please include:
- Clear description of the feature
- Use case and motivation
- Proposed implementation approach
- Any alternatives considered

## 📚 Resources

### Project Documentation
- [API Documentation](FRONTEND-API-DOCUMENTATION.md)
- [Railway Deployment Guide](RAILWAY-DEPLOYMENT-GUIDE.md)
- [Code Review Guidelines](CODE_REVIEW.md)

### External Resources
- [Node.js Best Practices](https://github.com/goldbergyoni/nodebestpractices)
- [MongoDB Best Practices](https://docs.mongodb.com/manual/best-practices/)
- [Express.js Guide](https://expressjs.com/en/guide/)

## 🤝 Code of Conduct

### Be Respectful
- Use welcoming and inclusive language
- Respect differing viewpoints and experiences
- Focus on what's best for the community

### Be Professional
- Keep discussions technical and constructive
- Provide helpful feedback
- Be patient with newcomers

## 🆘 Getting Help

- **Documentation Issues:** Create an issue with the `documentation` label
- **Bug Reports:** Use the bug report template
- **Questions:** Start a discussion in GitHub Discussions
- **Security Issues:** Email privately to [your-email@domain.com]

## 🎉 Recognition

Contributors will be:
- Listed in the project's CONTRIBUTORS.md file
- Mentioned in release notes for significant contributions
- Given commit access for consistent, quality contributions

Thank you for contributing to make this project better! 🚀
