class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :product

  validates :product_id, presence: true
  validates :user_id, presence: true
  validate :has_rating_or_description

  private

  def has_rating_or_description
    unless rating || description
      errors.add("rating or description", "requires rating or description")
    end
  end

end
