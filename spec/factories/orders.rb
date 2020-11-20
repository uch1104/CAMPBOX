FactoryBot.define do
  factory :order do
    rental_start_date { '2020-12-13' }
    rental_limit_date { '2020-12-15' }
    association :user
    association :item
  end
end
