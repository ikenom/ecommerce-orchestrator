# frozen_string_literal: true

class CreateShopifyProductJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_shopify_product

  def perform(user_id:, name:, price:, type:)
    Hutch.connect
    Hutch.publish("shopify.product.create",
                  vendor_user_id: user_id,
                  product_type: type,
                  product_name: name,
                  price: price,
                  tags: tags)
  end
end
