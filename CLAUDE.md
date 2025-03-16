# CLAUDE.md - Guide for Agents Working in This Repository

## Commands
- Build/start: `bin/dev`
- Run all tests: `bin/rspec`
- Run a single test: `bin/rspec spec/path/to/file_spec.rb:LINE_NUMBER`
- Lint code: `bin/rubocop`
- Security scan: `bin/brakeman`

## Code Style Guidelines
- Rails 8 patterns with RESTful controllers and models
- Two-space indentation, single quotes, symbol array syntax (`%i[]`)
- Model conventions: validations at top, class methods use `self.method_name`
- Controller conventions: before_actions at top, private methods at bottom
- Testing: RSpec with descriptive contexts, let blocks for setup
- Use pattern matching with `=>` for parameter destructuring
- Prefer parentheses-free method calls when reasonable
- Explicit returns avoided (use implicit returns)
- Rails standard naming conventions (snake_case for variables/methods, CamelCase for classes)
- Errors handled with Rails exceptions and flash messages
- Follows rubocop-rails-omakase style guide

## Database
- PostgreSQL in production, SQLite for development
- Use transactions for test isolation