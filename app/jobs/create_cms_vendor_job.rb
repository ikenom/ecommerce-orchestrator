# frozen_string_literal: true

class CreateCmsVendorJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_vendor

  def perform(vendor_id:, business_name:)
    Hutch.connect
    Hutch.publish("cms.vendor.create",
                  sender_id: vendor_id,
                  name: business_name)
  end
end
