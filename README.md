# Graphql Template

This repository serves as a default template for a Ruby on Rails (RoR) application using the --api flag with the Graphql gem. It includes a pre-configured setup with essential gems and tools to streamline API development.

## Table of Contents

- [Installation](#installation)
- [Customize](#customize)
- [Gems](#gems)
- [Rake Tasks](#rake-tasks)
- [Contact](#contact)

## Installation

1. **Clone:**

```bash
git clone https://github.com/Grigore-George-Mihai/graphql_template
```

## Customize

- Update the project name to reflect your application.
- Modify the [Scout APM](https://github.com/scoutapp/scout_apm_ruby) settings as needed, or remove them if application performance monitoring is not required.
- Rename `.env.development.template` to `.env.development` and `.env.test.template` to `.env.test`. Populate these files with the appropriate environment-specific variables.

## Gems

### API Framework
- 

### Pagination
- [Kaminari](https://github.com/kaminari/kaminari): A scope and engine-based pagination library for Rails, Sinatra, and other Ruby frameworks.

### Background Processing
- [Sidekiq](https://github.com/mperham/sidekiq): Efficient background processing for Ruby applications.

### Performance Monitoring
- [Scout APM](https://github.com/scoutapp/scout_apm_ruby): Application monitoring tool.
- [Bullet](https://github.com/flyerhzm/bullet): Detects N+1 queries and unused eager loading.

### Debugging
- [Byebug](https://github.com/deivid-rodriguez/byebug): Debugging tool for Ruby applications.

### Code Quality & Linting
- [Rubocop](https://github.com/rubocop/rubocop): Ruby static code analyzer.
- [Rubocop Factory Bot](https://github.com/rubocop/rubocop-factory_bot): Enforces best practices for FactoryBot.
- [Rubocop Faker](https://github.com/koic/rubocop-faker): Linter for using Faker.
- [Rubocop Migration](https://github.com/r7kamura/rubocop-migration): Lints for Rails migrations.
- [Rubocop Performance](https://github.com/rubocop/rubocop-performance): Performance-focused RuboCop checks.
- [Rubocop Rails](https://github.com/rubocop/rubocop-rails): Rails-specific linting rules.
- [Rubocop Rake](https://github.com/rubocop/rubocop-rake): Enforces best practices for Rake tasks.
- [Rubocop RSpec](https://github.com/rubocop/rubocop-rspec): Linter for RSpec tests.

### Testing
- [Factory Bot Rails](https://github.com/thoughtbot/factory_bot_rails): Provides fixtures replacement with a straightforward definition syntax.
- [Faker](https://github.com/faker-ruby/faker): A library for generating fake data.
- [RSpec Rails](https://github.com/rspec/rspec-rails): Testing framework for Rails.
- [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers): Simplifies testing Rails applications with RSpec.
- [SimpleCov](https://github.com/simplecov-ruby/simplecov): Code coverage analysis tool.
- [Rspec-Sidekiq](https://github.com/philostler/rspec-sidekiq): Testing framework for Sidekiq jobs.

### Security
- [Brakeman](https://github.com/presidentbeef/brakeman): Static analysis tool for finding security vulnerabilities in Rails applications.
- [Bundler Audit](https://github.com/rubysec/bundler-audit): Scans your Gemfile for known vulnerabilities.

### Environment Management
- [Dotenv Rails](https://github.com/bkeepers/dotenv): Loads environment variables from `.env`.

## Rake Tasks

Run the following rake task to check for security risks in your application:

```bash
rake security:check
```

This task runs tools like Brakeman and Bundler Audit to ensure your application is secure.

## Contact
For questions or further information, feel free to reach out via [LinkedIn](https://www.linkedin.com/in/grigore-george-mihai-73981b86/).
