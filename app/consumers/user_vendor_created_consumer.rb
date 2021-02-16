# frozen_string_literal: true

class UserVendorCreatedConsumer
  include Hutch::Consumer
  consume "user.vendor.created"
  queue_name "consumer_ecommerce_orchestrator_user_vendor_created"

  def process(message)
    CreateVendorJob.perform_later(
      user_id: message[:user_id],
      first_name: message[:first_name],
      last_name: message[:last_name],
      business_name: message[:business_name],
      email: message[:email],
      phone: message[:phone]
    )
  end
end
