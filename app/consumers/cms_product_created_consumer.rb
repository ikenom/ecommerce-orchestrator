# frozen_string_literal: true

class CmsProductCreatedConsumer
  include Hutch::Consumer
  consume "cms.product.created"
  queue_name "consumer_ecommerce_orchestrator_cms_product_created"

  def process(message)
    CreateProductJob.perform_later(
      cms_id: message[:cms_id],
      vendor_id: message[:vendor_id],
      name: message[:name],
      price: message[:price],
      type: message[:type]
    )
  end
end
