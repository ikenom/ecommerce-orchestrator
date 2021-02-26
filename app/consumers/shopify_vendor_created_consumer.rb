# frozen_string_literal: true

class ShopifyVendorCreatedConsumer
  include Hutch::Consumer
  consume "shopify.vendor.created"
  queue_name "consumer_ecommerce_orchestrator_shopify_vendor_created"

  def process(message)
    ShopifyEntityCreatedJob.perform_later(
      entity_id: message[:sender_id],
      shopify_id: message[:shopify_id]
    )
  end
end
