# revpub
RevPub is the reviewing and publishing feature used in dokspot.

## Usage
revpub works with Rails 5 onwards. You can add it to your Gemfile with:
```ruby
gem 'reviewer', github: 'dokspot/reviewer'
```

Then run `bundle install`

Next, you need to run the a couple generators.

In the following command you need to replace `MODEL` with the class name of model you will use with your reviews (frequently `Review`). This adds `accepted_at`, `rejected_at`, `cancelled_at`, and `user_id` to the MODEL.

```console
$ rails g revpub:reviews MODEL
```

Next, migrate the database:

```console
$ rails db:migrate
```

Next, add revpub to your models:
```ruby
class Review < ActiveRecord::Base
  review!
end
```
