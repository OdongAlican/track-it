FactoryBot.define do
  factory :user do
    username { 'test' }
    password { '123456' }
    age { 12 }
    id { '1' }
  end
end
