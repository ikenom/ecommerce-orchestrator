# frozen_string_literal: true

class DeleteShopifyProductJob < ApplicationJob
  queue_as :ecommerce_orchestrator_delete_shopify_product

  def perform(product_id:)
    Hutch.connect

    product = Product.find(product_id)
    Hutch.publish("shopify.product.delete",
                  sender_id: product_id,
                  product_id: product.shopify_id)
  end
end
