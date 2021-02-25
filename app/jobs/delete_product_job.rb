class DeleteProductJob < ApplicationJob
  queue_as :ecommerce_orchestrator_delete_product

  def perform(cms_id:)
    product = Product.find_by(cms_id: cms_id)
    DeleteShopifyProductJob.perform_later(product_id: product.id.to_s)
  end
end