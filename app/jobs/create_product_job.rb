# frozen_string_literal: true

class CreateProductJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_product

  def perform(vendor_id:, cms_id:, name:, price:, type:)
    vendor = Vendor.find(vendor_id)
    product = Product.create!(cms_id: cms_id, vendor: vendor)
    tags = ["cms_id:#{cms_id}"]

    CreateShopifyProductJob.perform_later(
      product_id: product.id.to_s,
      name: name,
      price: price,
      type: type,
      tags: tags
    )
  end
end
