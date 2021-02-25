# frozen_string_literal: true

class CmsProductCreatedConsumer
  include Hutch::Consumer
  consume "cms.product.updated"
  queue_name "consumer_ecommerce_orchestrator_cms_product_updated"

  def process(message)
    CreateShopifyProductJob.perform_later(
      cms_id: message[:cms_id],
      name: message[:product][:name],
      price: message[:product][:price],
      type: message[:product_type],
    )
  end
end
