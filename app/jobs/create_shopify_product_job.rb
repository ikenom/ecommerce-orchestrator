class CreateShopifyProductJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_shopify_product

  def perform(product_id:, name:, price:, type:, tags:)
    Hutch.connect
    Hutch.publish("shopify.product.create",
      sender_id: product_id,
      product_type: type,
      product_name: name,
      price: price,
      tags: tags
    )
  end
end