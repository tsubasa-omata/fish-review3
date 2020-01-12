FactoryBot.define do
  factory :user do
    name                  { 'User' }
    account_name          { '@user' }
    email                 { 'user@example.com' }
    password              { 'password' }
    password_confirmation { 'password' }
  end

  
end
