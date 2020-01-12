FactoryBot.define do
  factory :review do
    association :user
    association :fish
    taste_level         { 1 }
    season              { 1 }
    place               { '愛知県' }
    place_detail        { '海' }
    recipe              { '焼き' }
    preservation_period { 1 }
    fish_size           { 10 }
    blood               { false }
    taste_imp           { "a" * 10 }
  end
end
