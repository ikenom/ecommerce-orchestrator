# frozen_string_literal: true

class ShopifyProductCreatedJob < ApplicationJob
  queue_as :ecommerce_orchestrator_shopify_product_created

  def perform(product_id:, shopify_id:)
    product = Product.find(product_id)
    product.update!(shopify_id: shopify_id)
  end
end
