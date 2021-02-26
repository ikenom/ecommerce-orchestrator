# frozen_string_literal: true

class CmsVendorCreatedJob < ApplicationJob
  queue_as :ecommerce_orchestrator_cms_vendor_created

  def perform(vendor_id:, cms_id:)
    vendor = Vendor.find(vendor_id)
    vendor.update!(cms_id: cms_id)
  end
end
