# Devise::Activeresource
`Devise::Activeresource` is an adapter that allows you to use [devise](https://github.com/heartcombo/devise) with [Active Resource](https://github.com/rails/activeresource) in your models. It supports `Devise >= 4.7.1` and `Active Resource 5.1`. It may work with earlier version of `devise` and `activeresource`, but it's not tested for those versions.

## Usage
In the `config/inititializer/devise.rb` file, replace the default orm adapter:
```ruby
  require 'devise/orm/active_record'
```

with the following:
```ruby
  require 'devise/orm/active_resource'
```

### Generators and API
This gem does not provide model generators because `ActiveResource` models adapt their attributes to the `REST API` you are consuming. These models may have an schema, but this is not enough to ensure proper operation.

To ensure the proper functioning of this gem, verify the `REST API` you are consuming, so that it contains the attributes you need for the operation of each module that you include in the model.

For more information of the attributes you need for module, look at the [devise documentation](https://github.com/heartcombo/devise/blob/master/README.md).

### Modules
This gem adds one aditional module to devise:
* Resource Authenticatable: This is a monkey patch, and it's needed if you want to use the [Database Authenticable module](https://www.rubydoc.info/github/heartcombo/devise/master/Devise/Models/DatabaseAuthenticatable) of `devise`.

### Models
The options to configure your models are the same of devise. The only consideration, is the `Resource Authenticatable` module. An example of a model:

```ruby
class User < ActiveResource::Base
  devise :database_authenticatable, :rememberable,
         :resource_authenticatable

  self.site = 'https://some.api.com'
end

```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'devise-activeresource'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install devise-activeresource
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
