# reviewer
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

Next, add `review!` and `reviewable!` to your models:

```ruby
class Review < ActiveRecord::Base
  review!
end

class ObjectToReview < ActiveRecord::Base
  reviewable!
end
```

### API

#### review! Helper
Classes that use the `review!` helper will now respond to the following methods:
```ruby
# Scopes
Review.accepted                 # returns all accepted reviews
Review.rejected                 # returns all rejected reviews
Review.cancelled                # returns all cancelled reviews
Review.pending                  # returns all pending reviews
# Status
@review.status                  # returns the status of a given review
@review.status?(status_name)    # returns boolean
@review.accepted?               # returns true if status == :accepted
@review.rejected?               # returns true if status == :rejected
@review.pending?                # returns true if status == :pending
@review.cancelled?              # returns true if status == :cancelled
# Actions
@review.accept                  # only the user belonging to the Review can accept it
@review.reject                  # only the user belonging to the Review can reject it
@review.cancel                  # cancels the review
```
