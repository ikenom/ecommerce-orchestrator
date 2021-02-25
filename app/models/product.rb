# frozen_string_literal: true

class Product
  include Mongoid::Document

  field :cms_id, type: String
  field :shopify_id, type: String

  index({ cms_id: 1 }, { unique: true })

  belongs_to :vendor

  validates :cms_id, presence: true
end
