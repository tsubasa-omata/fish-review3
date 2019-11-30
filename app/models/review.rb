class Review < ApplicationRecord
  belongs_to :user
  belongs_to :fish
  has_one_attached :avatar
  default_scope -> { order(created_at: :desc) }
  with_options presence: true do
    validates :taste_level
    validates :season
    validates :place
    validates :fish_size
  end

  validates :taste_level,  length:       { in: 1..5 }
  validates :taste_imp,    length:       { maximum: 200 }
  validates :place_detail, length:       { maximum: 10 }
  validates :recipe,       length:       { maximum: 10 }
  validates :season,       numericality: { :less_than_or_equal_to => 12 }
end
