FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { 'hoge12' }
    password_confirmation { 'hoge12' }
    family_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    family_name_kana { Gimei.last.katakana }
    first_name_kana { Gimei.first.katakana }
    birth_date { Faker::Date.birthday }
  end
end