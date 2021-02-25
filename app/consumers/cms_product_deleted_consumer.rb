# frozen_string_literal: true

class CmsProductDeletedConsumer
  include Hutch::Consumer
  consume "cms.product.deleted"
  queue_name "consumer_ecommerce_orchestrator_cms_product_deleted"

  def process(message)
    DeleteProductJob.perform_later(
      cms_id: message[:cms_id]
    )
  end
end
