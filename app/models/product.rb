# frozen_string_literal: true

class Product < ShopifyEntity
  include CmsEntity

  belongs_to :vendor
  validates :cms_id, presence: true
end
