class User
  include Mongoid::Document

  field :email, type: String
  field :auth_id, type: String

  validates :email, presence: true
end