# frozen_string_literal: true

class CmsProductUpdatedConsumer
  include Hutch::Consumer
  consume "cms.product.updated"
  queue_name "consumer_ecommerce_orchestrator_cms_product_updated"

  def process(message)
    UpdateProductJob.perform_later(
      cms_id: message[:cms_id],
      name: message[:name],
      price: message[:price],
    )
  end
end
