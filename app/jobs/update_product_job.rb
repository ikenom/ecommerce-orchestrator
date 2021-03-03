# frozen_string_literal: true

class UpdateProductJob < ApplicationJob
  queue_as :ecommerce_orchestrator_update_product

  def perform(cms_id:, name:, price:)
    product = Product.find_by(cms_id: cms_id)

    UpdateShopifyProductJob.perform_later(
      product_id: product.id.to_s,
      name: name,
      price: price
    )
  end
end
