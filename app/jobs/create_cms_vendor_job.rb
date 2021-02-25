# frozen_string_literal: true

class CreateCmsVendorJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_vendor

  def perform(user_id:, business_name:)
    Hutch.connect
    Hutch.publish("cms.restaurant.create",
                  user_id: user_id,
                  name: business_name)
  end
end
