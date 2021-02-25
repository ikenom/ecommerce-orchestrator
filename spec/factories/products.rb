# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    cms_id { Faker::Alphanumeric.alpha }
    shopify_id { Faker::Alphanumeric.alpha }

    vendor { association :vendor }
  end
end
