# frozen_string_literal: true

class ShopifyProductCreatedConsumer
  include Hutch::Consumer
  consume "shopify.product.created"
  queue_name "consumer_ecommerce_orchestrator_shopify_product_created"

  def process(message)
    ShopifyEntityCreatedJob.perform_later(
      entity_id: message[:sender_id],
      shopify_id: message[:shopify_id]
    )
  end
end
