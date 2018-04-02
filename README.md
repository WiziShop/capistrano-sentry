# Capistrano::Sentry

It's a callback to sentry application after every deployment you have. 

please check the [reference](https://docs.sentry.io/learn/releases/)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-sentry', github: 'git@github.com:resumecompanion/capistrano-sentry.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-sentry

## Usage

You need to setup the `organization`, `projects` and `sha version` you want to append after the branch name 

### Get token from sentry 

[Here](https://docs.sentry.io/api/auth/)


### Setting in your deploy.rb


```

# In deploy.rb

set: :sentry_organization, 'your organization name' 
set: :sentry_token, 'the token you get from last section'
set: :branch_tag, 'the branch tag in the release'
```

You may have staging project and production project in sentry. 
So you need to configure the projects name in different name. 

```ruby

# In staging.rb

set: :sentry_projects, ['your first project', 'your second project']

# current version name will append after your branch name 
set: :current_version, `git rev-parse HEAD`.strip

```

The `current_version` help you differ diffferent deployment in the staging enviornement 
like 

`release/2.0-sha1`
`release/2.0-sha2`



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/capistrano-sentry. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Capistrano::Sentry project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/capistrano-sentry/blob/master/CODE_OF_CONDUCT.md).
