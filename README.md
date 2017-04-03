# revpub
RevPub is the reviewing and publishing feature used in dokspot.

## Usage
revpub works with Rails 5 onwards. You can add it to your Gemfile with:
```ruby
gem 'revpub'
```

Then run `bundle install`

Next, you need to run the a couple generators.

In the following command you need to replace `MODEL` with the class name of you want to use revpub with. (frequently `Product`). This adds `published_at`, `retired_a`, and `next_version_id` to the MODEL.

```console
$ rails g revpub:model MODEL
```

In the following command you need to replace `MODEL` with the class name of model you will use with revpub reviews (frequently `Review`). This adds `accepted_at`, `rejected_at`, `cancelled_at`, and `user_id` to the MODEL.

```console
$ rails g revpub:reviews MODEL
```

Next, migrate the database:

```console
$ rails db:migrate
```

Next, add revpub to your models:
```ruby
class Product < ActiveRecord::Base
  revpub!
end

class Review < ActiveRecord::Base
  review!
end
```

Next, you will need to implement a couple methods in your model that revpub needs to be able to call.
```ruby
class YourClass < ActiveRecord::Base
  
end
```
