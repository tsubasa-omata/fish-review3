FactoryBot.define do
  factory :user do
    name                    { 'User' }
    sequence(:account_name) { |n| "@user#{n}" }
    sequence(:email)        { |n| "user#{n}@example.com" }
    password                { 'password' }
    password_confirmation   { 'password' }
    activated            { true }

    trait :unactivated do
      activated { false }
    end

  end


end
