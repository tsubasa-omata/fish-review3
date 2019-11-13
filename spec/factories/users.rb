FactoryBot.define do
  factory :user do
    name                  { 'User' }
    account_name          { 'User' }
    email                 { 'user@example.com' }
    password              { 'password' }
    password_confirmation { 'password' }
  end
end
