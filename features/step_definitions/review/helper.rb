def create_r_pending
  @review = Review.create
  expect(@review.pending?).to be_truthy
end

def create_r_accepted
  create_r_pending
  # @review.update(accepted_at: Time.now)
  expect { @review.accept! }.to change(@review, :status).from(:pending).to(:accepted)
end

def create_r_rejected
  create_r_pending
  # @review.update(rejected_at: Time.now)
  expect { @review.reject! }.to change(@review, :status).from(:pending).to(:rejected)
end

def create_r_cancelled
  create_r_pending
  # @review.update(cancelled_at: Time.now)
  expect { @review.cancel! }.to change(@review, :status).from(:pending).to(:cancelled)
end
