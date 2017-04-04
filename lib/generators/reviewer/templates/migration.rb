class ReviewerCreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references  :user    , index: true , polymorphic: true
      t.references  :item         , index: true , polymorphic: true
      t.timestamp   :accepted_at
      t.timestamp   :rejected_at
      t.timestamp   :cancelled_at
      t.timestamps  null: false
    end
  end
end
