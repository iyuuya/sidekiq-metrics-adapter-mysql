# Sidekiq::Metrics::Adapter::Mysql

MySQL adapter for [sidekiq-metrics](https://github.com/iyuuya/sidekiq-metrics).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-metrics-adapter-mysql'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-metrics-adapter-mysql

## Usage

```ruby
Sidekiq::Metrics.configure do |config|
  config.adatper = Sidekiq::Metrics::Adapter::Mysql.new({
    database: 'DB_NAME',
    username: 'DB_USERNAME',
    password: 'DB_PASSWORD'
    host: 'localhost'
    port: 3306,
      ...
  },
  'table_name',
  async: true,
  sidekiq_worker_options: {
    queue: :default,
    retry: 5
    ...
  })
end
```

see also : https://github.com/brianmario/mysql2#connection-options

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sidekiq-metrics-adapter-mysql. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Sidekiq::Metrics::Adapter::Mysql project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sidekiq-metrics-adapter-mysql/blob/master/CODE_OF_CONDUCT.md).

## License

MIT License
