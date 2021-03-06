# frozen_string_literal: true

class Vendor < ShopifyEntity
  include CmsEntity

  field :business_name, type: String
  field :phone, type: String
  field :first_name, type: String
  field :last_name, type: String

  belongs_to :user

  validates :business_name, :phone, :first_name, :last_name, presence: true
end
