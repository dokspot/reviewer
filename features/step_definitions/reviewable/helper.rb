def create_p_draft
  @paper = Paper.create
  3.times { User.create(paper: @paper) }
end

def create_p_pending_review
  create_p_draft
  @paper.review!
end

def create_p_rejected
  create_p_pending_review
  @paper.reviews.first.reject!
end

def create_p_reviewed
  create_p_pending_review
  @paper.reviews.each { |r| r.accept! }
end
