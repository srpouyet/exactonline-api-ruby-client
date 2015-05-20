# Elmas

Elmas means diamond, but in this case it's an API wrapper for [Exact Online](https://developers.exactonline.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elmas'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elmas

## Usage

You have to have an Exact Online account and an app setup to connect with.

You have to set a few variables to make a connection possible. I'd suggest using environment variables set with [dotenv](https://github.com/bkeepers/dotenv) for that. (You can of course hardcode them, but that is not very secure :-) )


Then configure Elmas like this

```ruby
Elmas.configure do |config|
  config.client_id = ENV['client_id'],
  config.client_secret = ENV['client_secret']
  config.access_token = Elmas.authorize(ENV['user_name'], ENV['password'])
end

#The client will now be authorized for 10 minutes,
# if there are requests the time will be reset,
# otherwise authorization should be called again.
unless Elmas.authorized?
  Elmas.configure do |config|
    config.access_token = Elmas.authorize(ENV['user_name'], ENV['password'])
  end
end
```

To find a contact

```ruby
contact = Elmas::Contact.new(id: "23445")
contact.find
# path = /crm/Contacts?$filter=ID eq guid'23445'
```

To find a contact with specific filters
```ruby
contact = Elmas::Contact.new(first_name: "Karel", id: "23")
contact.find_by([:first_name])
# path = /crm/Contacts?$filter=first_name eq 'Karel'
```

To find all contacts
```ruby
contact = Elmas::Contact.new
contact.find_all
# path = /crm/Contacts
```

To create a new contact

```ruby
contact = Elmas::Contact.new(first_name: "Karel", last_name: "Appel", id: "2378712")
contact.save
```

###Divisions and Endpoints

Usually in the exact wrapper you need a division number, this one will be set on authorization checks (with `/Current/Me` endpoint). Sometimes you need to do a request without the division number, or even without the standard `/api/v1` endpoint. Like so:

```ruby
response = Elmas.get('/api/oauth2/token', no_endpoint: true, no_division: true)
response = Elmas.get('/Current/Me', no_division: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/elmas/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Hoppinger

This gem was created by [Hoppinger](http://www.hoppinger.com)

[![forthebadge](http://forthebadge.com/images/badges/built-with-ruby.svg)](http://www.hoppinger.com)
