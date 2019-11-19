class Review < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :taste_level
    validates :season
    validates :place
    validates :fish_size
  end
  
  validates :taste_level,  length: { in: 1..5 }
  validates :place_detail, length: { maxmum: 10 }
  validates :recipe,       length: { maxmum: 10 }
  
end
