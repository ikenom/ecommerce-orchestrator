# frozen_string_literal: true

class CmsProductCreatedConsumer
  include Hutch::Consumer
  consume "cms.product.added"
  queue_name "consumer_ecommerce_orchestrator_cms_product_created"

  def process(message)
    CreateShopifyProductJob.perform_later(
      cms_id: message[:cms_id],
      name: message[:product][:name],
      price: message[:product][:price],
      type: message[:product_type],
      tags: ["cms_id:#{message[:product_id]}"]
    )
  end
end
