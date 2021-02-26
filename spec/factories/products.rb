# frozen_string_literal: true

FactoryBot.define do
  factory :product, class: Product, parent: :shopify_entity do
    cms_id { Faker::Alphanumeric.alpha }
    vendor { association :vendor }
  end
end
