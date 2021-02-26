# frozen_string_literal: true

class ShopifyEntity
  include Mongoid::Document

  field :shopify_id, type: String
  index({ shopify_id: 1 }, { unique: true })
end
