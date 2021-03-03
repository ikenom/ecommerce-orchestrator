# frozen_string_literal: true

class UpdateShopifyProductJob < ApplicationJob
  queue_as :ecommerce_orchestrator_update_shopify_product

  def perform(product_id:, name:, price:)
    Hutch.connect

    product = Product.find(product_id)
    Hutch.publish("shopify.product.update",
                  sender_id: product_id,
                  product_id: product.shopify_id,
                  product_name: name,
                  price: price,
                  tags: [])
  end
end
