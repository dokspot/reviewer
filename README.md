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
## Configuring initializer
Reviewer provides you with a couple custom configurations to get your application working the way you want. You can modify these options in `/config/initializers/reviewer.rb`. Please see these options below:
```ruby
Reviewer.config do |c|
  c.user_only       = true        # Only the user associated with a review can approve! or reject! it
  c.allowed_change  = false       # Whether a object can be updated while it is being reviewed
  c.user_model      = :user       # Your user model
  c.reviewers       = :reviewers  # Name of the association or method to query for the reviewers
end
```

## Configuring Models

### Configuring your model to use `review!`
Add `review!` to your `Review` model and you will gain access to all the helper methods required.
```ruby
class Review < ActiveRecord::Base
  review!
end
```

NOTE: By default, only the user associated with the Review can `accept!` and `reject!` a review, this can be disabled in `/config/initializers/reviewer.rb`.

### Configuring your model to use `reviewable!`
Add `reviewable!` to your `Model` (we will use `Paper` here) model and you will gain access to all the helper methods required.

Additionally, you need to implement a couple methods to make reviewer play nicely with your application.
```ruby
class Paper < ActiveRecord::Base
  reviewable!
  
  # You either need a association called :reviewers
  # Note: you can change this in /config/initializers/reviewer.rb
  has_many :reviewers
  # Or you need a method called `reviewers` that returns an array of users.
  def reviewers
    Reviewer.all
  end
end
```

## API

### review! Helper

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

### reviewable! Helper

Classes that use the `reviewable!` helper will now respond to the following methods:
```ruby
# Scopes
Paper.draft                     # returns all objects that have not been reviewed
Paper.pending_review            # returns all objects with pending reviews
Paper.rejected                  # returns all objects with rejected reviews
Paper.reviewed                  # returns all objects that have been reviewed
# Status
@paper.status                   # returns the status of the object
@paper.status?(status_name)     # returns boolean
@paper.draft?                   # returns true if there are no review (excluding cancelled reviews)
@paper.pending_review?          # returns true if there are reviews that have not been responded to
@paper.reviewed?                # returns true if all the reviews have been accepted
@paper.rejected?                # returns true if any review has been rejected
@paper.reviewable?              # returns true if the object can be reviewed (does it have reviewers)
@paper.cancelable?              # returns true if the reviews can be cancelled
# Actions
@paper.review!                  # creates a Review for every reviewer
@paper.cancel!                  # cancels all reviews
```

## Example

```ruby

@paper = Paper.create(name: "My physics paper")
# Add reviewers
@paper.reviewers << User.create     # NOTE: Using a has_many relationship
@paper.reviewers << User.create     # NOTE: Using a has_many relationship
@paper.save

# Let's ask our reviewers to review our paper
@paper.review!                      # Creates a Review for every reviewer

# Oh no! I made a mistake, luckily I can cancel my reviews!
@paper.cancel!                      # Cancels all object reviews

@paper.update(name: "My chemistry paper")
# Thats better, now let's ask our reviewers to check it out again
@paper.review!

# NOTE: For this example I disabled only_user (see your /config/initializers/reviewer.rb file)
# Accept the reviews
@paper.reviews.each { |r| r.accept! }

@paper.reviewed?                    # Should return true
```
