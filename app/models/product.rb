class Product
  include Mongoid::Document

  field :cms_id, type: String
  field :shopify_id, type: String

  belongs_to :vendor

  validates :cms_id, presence: true
end