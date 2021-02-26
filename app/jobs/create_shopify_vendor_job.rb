# frozen_string_literal: true

class CreateShopifyVendorJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_shopify_vendor

  def perform(vendor_id:, first_name:, last_name:, business_name:, email:, phone:)
    Hutch.connect
    Hutch.publish("shopify.vendor.create",
                  sender_id: vendor_id,
                  first_name: first_name,
                  last_name: last_name,
                  business_name: business_name,
                  email: email,
                  phone: phone)
  end
end
