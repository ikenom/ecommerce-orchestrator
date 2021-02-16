# frozen_string_literal: true

class CmsProductCreatedConsumer
  include Hutch::Consumer
  consume "user.vendor.create"
  queue_name "consumer_ecommerce_orchestrator_cms_product_create"

  def process(message)

  end
end
