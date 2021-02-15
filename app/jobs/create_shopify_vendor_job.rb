class CreateShopifyVendorJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_shopify_vendor

  def perform(user_id:, first_name:, last_name:, business_name:, email:, phone:)
    Hutch.connect
    Hutch.publish("shopify.vendor.create",
      user_id: user_id,
      first_name: first_name,
      last_name: last_name,
      business_name: business_name,
      email: email,
      phone: phone
    )
  end
end