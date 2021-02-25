# frozen_string_literal: true

class ShopifyProductDeletedConsumer
  include Hutch::Consumer
  consume "shopify.product.deleted"
  queue_name "consumer_ecommerce_orchestrator_shopify_product_deleted"

  def process(message)
    ShopifyProductDeletedJob.perform_later(
      product_id: message[:sender_id],
    )
  end
end
