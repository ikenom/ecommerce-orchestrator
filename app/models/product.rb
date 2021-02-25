class Product
  include Mongoid::Document

  field :cms_id, type: String
  field :shopify_id, type: String

  belongs_to :vendor
end