# spec/factories/items.rb
FactoryBot.define do
  factory :measurement do
    date { 'December 17, 1995 03:24:00' }
    duration { 2.0 }
    activity_id { 1 }
  end
end
