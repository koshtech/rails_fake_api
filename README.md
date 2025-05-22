# RailsFakeApi

RailsFakeApi is a Ruby on Rails engine that provides a simple, in-memory (file-based) fake API server, similar to json-server. It runs alongside your main Rails application, allowing you to easily mock API endpoints for frontend development, testing, or quick prototyping without setting up a full database.

Data is persisted to JSON files within your Rails application's `db/fake_data` directory, making it easy to inspect, modify, and reset your mock data.

## Features

- **File-based Persistence**: Data is stored in plain JSON files within your Rails app's `db/fake_data` directory.
- **Dynamic Resources**: Automatically handles any resource name (e.g., `/fake_api/posts`, `/fake_api/users`).
- **Full CRUD Operations**: Supports GET, POST, PUT/PATCH, and DELETE requests.
- **Automatic ID Generation**: Assigns unique IDs to new records.
- **Seamless Integration**: Runs as a Rails engine, easily mountable in any Rails application.

## Installation

Install the gem by running:

```bash
$ bundle add rails_fake_api
```

Or add it manually to your Gemfile:

```ruby
# Gemfile
gem 'rails_fake_api', path: 'path/to/your/rails_fake_api_gem' # For local development
# gem 'rails_fake_api' # Uncomment when published on RubyGems.org
```

Then install dependencies:

```bash
$ bundle install
```

If you’re not using Bundler:

```bash
$ gem install rails_fake_api
```

## Setup

### Mount the Engine

In `config/routes.rb`, mount the engine:

```ruby
Rails.application.routes.draw do
  mount RailsFakeApi::Engine, at: "/"
end
```

### Create Data Directory

```bash
$ mkdir -p db/fake_data
```

### Initialize Data Files

Create empty JSON files for your resources, like:

```json
// db/fake_data/posts.json
[]
```

## Usage

Start your Rails server:

```bash
$ rails s
```

### Examples

- **GET /fake_api/posts**

```bash
curl http://localhost:3000/fake_api/posts
# => []
```

- **POST /fake_api/posts**

```bash
curl -X POST -H "Content-Type: application/json" -d '{"title": "My First Post", "author": "Me"}' http://localhost:3000/fake_api/posts
# => {"title": "My First Post", "author": "Me", "id": 1}
```

- **GET /fake_api/posts/1**

```bash
curl http://localhost:3000/fake_api/posts/1
```

- **PUT /fake_api/posts/1**

```bash
curl -X PUT -H "Content-Type: application/json" -d '{"title": "Updated Post", "status": "published"}' http://localhost:3000/fake_api/posts/1
```

- **DELETE /fake_api/posts/1**

```bash
curl -X DELETE http://localhost:3000/fake_api/posts/1
# => HTTP 204 No Content
```

## Development

After cloning the repo:

```bash
$ bin/setup
$ rake test-unit
$ bin/console
```

To install locally:

```bash
$ bundle exec rake install
```

To release:

1. Update the version in `version.rb`
2. Run:

```bash
$ bundle exec rake release
```

## Contributing

Bug reports and pull requests are welcome at [https://github.com/koshtech/rails_fake_api](https://github.com/koshtech/rails_fake_api). Please adhere to the [code of conduct](https://github.com/koshtech/rails_fake_api/blob/master/CODE_OF_CONDUCT.md).

## License

This project is licensed under the terms of the **GNU Affero General Public License v3.0**. See the [LICENSE](LICENSE) file or visit [https://www.gnu.org/licenses/agpl-3.0.html](https://www.gnu.org/licenses/agpl-3.0.html) for details.

## Code of Conduct

All contributors are expected to follow the [code of conduct](https://github.com/koshtech/rails_fake_api/blob/master/CODE_OF_CONDUCT.md).

## Available in Other Languages

- [Português do Brasil](docs/pt-BR/README.md)
- [Código de Conduta em Português do Brasil](docs/pt-BR/CODE_OF_CONDUCT.md)
- [Contribuindo em Português do Brasil](docs/pt-BR/CONTRIBUTING.md)
