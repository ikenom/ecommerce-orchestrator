# frozen_string_literal: true

class ShopifyProductDeletedJob < ApplicationJob
  queue_as :ecommerce_orchestrator_shopify_product_deleted

  def perform(product_id:)
    product = Product.find(product_id)
    product.delete
  end
end
