# frozen_string_literal: true

class CreateVendorJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_vendor

  def perform(user_id:, first_name:, last_name:, business_name:, email:, phone:)
    user = User.find(user_id)
    vendor = Vendor.create!(
      first_name: first_name,
      last_name: last_name,
      business_name: business_name,
      email: email,
      phone: phone,
      user: user
    )

    CreateShopifyVendorJob.perform_later(
      sender_id: vendor.id.to_s,
      first_name: vendor.first_name,
      last_name: vendor.last_name,
      business_name: vendor.business_name,
      email: vendor.email,
      phone: vendor.phone
    )

    CreateCmsVendorJob.perform_later(sender_id: vendor.id.to_s, business_name: vendor.business_name)
  end
end
