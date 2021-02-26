# frozen_string_literal: true

class Product < ShopifyEntity
  field :cms_id, type: String
  index({ cms_id: 1 }, { unique: true })

  belongs_to :vendor

  validates :cms_id, presence: true
end
