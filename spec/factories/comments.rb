FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { nil }
    review { nil }
  end
end
