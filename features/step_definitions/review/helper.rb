def create_r_pending
  @review = Review.create
end

def create_r_accepted
  create_r_pending
  @review.update(accepted_at: Time.now)
end

def create_r_rejected
  create_r_pending
  @review.update(rejected_at: Time.now)
end

def create_r_cancelled
  create_r_pending
  @review.update(cancelled_at: Time.now)
end
