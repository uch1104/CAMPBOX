FactoryBot.define do
  factory :address do
    post_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { '品川' }
    house_number { '1-1' }
    building_name { '品川ハイツ101' }
    phone_number { '09012345678' }
    association :user
  end
end
