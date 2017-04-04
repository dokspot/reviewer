def create_p_draft
  @paper = Paper.create
  expect {
    3.times { User.create(paper: @paper) }
  }.to change(User, :count).by(3)
  expect(@paper.draft?).to be_truthy
end

def create_p_pending_review
  create_p_draft
  expect { @paper.review! }.to change(Review, :count).by(@paper.reviewers.count)
  expect(@paper.pending_review?).to be_truthy
end

def create_p_rejected
  create_p_pending_review
  @review = @paper.reviews.first
  expect { @review.reject! }.to change(@review, :status).from(:pending).to(:rejected)
  expect(@paper.rejected?).to be_truthy
end

def create_p_reviewed
  create_p_pending_review
  @paper.reviews.each do |r|
    r.accept!
    expect(r.accepted?).to be_truthy
  end
  expect(@paper.reviewed?).to be_truthy
end
