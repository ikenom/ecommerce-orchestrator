# frozen_string_literal: true

FactoryBot.define do
  factory :shopify_entity do
    shopify_id { Faker::Alphanumeric.alpha }
  end
end
