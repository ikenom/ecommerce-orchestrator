# frozen_string_literal: true

class UserVendorCreatedConsumer
  include Hutch::Consumer
  consume "user.vendor.created"
  queue_name "consumer_ecommerce_orchestrator_cms_product_created"

  def process(message)

  end
end
