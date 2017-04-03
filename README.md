# reviewer
RevPub is the reviewing and publishing feature used in dokspot.

## Usage
revpub works with Rails 5 onwards. You can add it to your Gemfile with:
```ruby
gem 'reviewer', github: 'dokspot/reviewer'
```

Then run 
```console
$ bundle install
```

Next, you need to run the a couple generators.

In the following command you need to replace `MODEL` with the class name of model you will use with your reviews (frequently `Review`). This adds `accepted_at`, `rejected_at`, `cancelled_at`, and `user_id` to the MODEL. It also generate a initializer, if your user model is not User, you will want to head over to `/config/initializers/reviewer.rb` and modify the user model referenced.

```console
$ rails g reviewer:install MODEL
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
@review.accept!                 # only the user belonging to the Review can accept it
@review.reject!                 # only the user belonging to the Review can reject it
@review.cancel!                 # cancels the review
# Associations
@review.object_to_review        # Object being reviewed
@review.user                    # User assigned to Review
```
#### reviewable! Helper
Classes that use the `reviewable!` helper will now respond to the following methods:
```ruby
# Scopes
ObjectToReview.draft            # returns all objects that have not been reviewed
ObjectToReview.pending_review   # returns all objects with pending reviews
ObjectToReview.rejected         # returns all objects with rejected reviews
ObjectToReview.reviewed         # returns all objects that have been reviewed
# Status
@object.status                  # returns the status of the object
@object.status?(status_name)    # returns boolean
@object.draft?                  # returns true if there are no review (excluding cancelled reviews)
@object.pending_review?         # returns true if there are reviews that have not been responded to
@object.reviewed?               # returns true if all the reviews have been accepted
@object.rejected?               # returns true if any review has been rejected
@object.cancelable?             # returns true if the reviews can be cancelled
# Actions
@object.review!                 # creates a Review for every reviewer
@object.cancel!                 # cancels all reviews
```
