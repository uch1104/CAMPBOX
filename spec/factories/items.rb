FactoryBot.define do
  factory :item do
    name { Faker::Lorem.sentence }
    price { Faker::Number.between(from: 500, to: 100_000) }
    description { Faker::Lorem.sentence }
    precaution { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 13) }
    condition_id { Faker::Number.between(from: 2, to: 6) }
    cost_id { Faker::Number.between(from: 2, to: 4) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    shipping_method_id { Faker::Number.between(from: 2, to: 3) }
    future_date = Faker::Date.between(from: Date.today+1, to: '2025-01-01')
    start_date { future_date }
    limit_date { Faker::Date.between(from: future_date, to: '2030-01-01') }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/camp-image.jpeg'), filename: 'camp-image.jpeg')
    end
  end
end
