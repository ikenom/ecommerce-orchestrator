# frozen_string_literal: true

class CmsVendorCreatedConsumer
  include Hutch::Consumer
  consume "cms.vendor.created"
  queue_name "consumer_ecommerce_orchestrator_cms_vendor_created"

  def process(message)
    CmsVendorCreatedJob.perform_later(
      vendor_id: message[:sender_id],
      cms_id: message[:cms_id]
    )
  end
end
