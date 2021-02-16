class CreateShopifyVendorJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_vendor

  def perform(user_id:, first_name:, last_name:, business_name:, email:, phone:)
    CreateShopifyVendorJob.perform_later(
      user_id: user_id,
      first_name: first_name,
      last_name: last_name,
      business_name: business_name,
      email: email,
      phone: phone
    )

    CreateCmsVendorJob.perform_later(user_id: user_id, business_name: business_name)
  end
end