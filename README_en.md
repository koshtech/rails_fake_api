# RailsFakeApi

RailsFakeApi is a Ruby on Rails engine that provides a simple, file-based fake API server, similar to `json-server`. It runs alongside your main Rails application, allowing you to easily mock API endpoints for frontend development, testing, or quick prototyping without setting up a full database.

Data is persisted to JSON files within your Rails application's `db/fake_data` directory, making it easy to inspect, modify, and reset your mock data.

## Features

- **File-based Persistence**: Stores data in plain `.json` files inside the `db/fake_data` directory.
- **Dynamic Resources**: Automatically handles any resource name (e.g., `/fake_api/posts`, `/fake_api/users`).
- **Full CRUD Support**: Handles `GET`, `POST`, `PUT/PATCH`, and `DELETE` requests.
- **Automatic ID Generation**: Assigns unique IDs to new records.
- **Seamless Integration**: Mounts as a Rails engine with minimal setup.

## Installation

Install the gem and add it to your application's Gemfile:

```bash
$ bundle add rails_fake_api
```

Alternatively, add it manually to the `Gemfile`:

```ruby
# Gemfile
gem 'rails_fake_api', path: 'path/to/your/rails_fake_api_gem' # for local development
# gem 'rails_fake_api' # for installation via RubyGems
```

Then install the dependencies:

```bash
$ bundle install
```

Or install manually if you're not using Bundler:

```bash
$ gem install rails_fake_api
```

## Setup

### Mount the Engine

Add the following to your `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  mount RailsFakeApi::Engine, at: "/"
end
```

### Create the Data Directory

```bash
$ mkdir -p db/fake_data
```

### Initialize Data Files

Create empty JSON files for each resource you plan to use. For example:

```json
# db/fake_data/posts.json
[]
```

## Usage

Start your Rails server:

```bash
$ rails s
```

Then you can make requests to the fake API using curl, Postman, or your frontend application.

### Example Requests

- **GET /fake_api/posts**

```bash
$ curl http://localhost:3000/fake_api/posts
```

Expected Output:

```json
[]
```

- **POST /fake_api/posts**

```bash
$ curl -X POST -H "Content-Type: application/json" -d '{"title": "My First Post", "author": "Me"}' http://localhost:3000/fake_api/posts
```

Expected Output:

```json
{"title": "My First Post", "author": "Me", "id": 1}
```

- **GET /fake_api/posts/1**

```bash
$ curl http://localhost:3000/fake_api/posts/1
```

Expected Output:

```json
{"title": "My First Post", "author": "Me", "id": 1}
```

- **PUT /fake_api/posts/1**

```bash
$ curl -X PUT -H "Content-Type: application/json" -d '{"title": "Updated Post", "status": "published"}' http://localhost:3000/fake_api/posts/1
```

Expected Output:

```json
{"title": "Updated Post", "author": "Me", "id": 1, "status": "published"}
```

- **DELETE /fake_api/posts/1**

```bash
$ curl -X DELETE http://localhost:3000/fake_api/posts/1
```

Expected Output: Status `204 No Content`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Run `rake test-unit` to execute tests. You can also use `bin/console` for an interactive prompt.

To install the gem locally:

```bash
$ bundle exec rake install
```

To release a new version:

1. Update the version in `lib/rails_fake_api/version.rb`.
2. Run:

```bash
$ bundle exec rake release
```

This will tag the release, push it to GitHub, and publish the gem to [RubyGems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome at [GitHub](https://github.com/[USERNAME]/rails_fake_api). This project adheres to a [Code of Conduct](https://github.com/[USERNAME]/rails_fake_api/blob/master/CODE_OF_CONDUCT.md) to foster a welcoming environment.

## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

All participants are expected to follow the [Code of Conduct](https://github.com/[USERNAME]/rails_fake_api/blob/master/CODE_OF_CONDUCT.md).

## Other Languages

- [Portuguese (Brazil)](docs/pt-BR/README.md)
- [Code of Conduct in Portuguese](docs/pt-BR/CODE_OF_CONDUCT.md)
- [Contributing in Portuguese](docs/pt-BR/CONTRIBUTING.md)
