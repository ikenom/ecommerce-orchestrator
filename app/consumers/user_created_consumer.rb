# frozen_string_literal: true

class UserCreatedConsumer
  include Hutch::Consumer
  consume "user.created"
  queue_name "consumer_ecommerce_orchestrator_user_created"

  def process(message)
    UserCreatedJob.perform_later(
      user_id: message[:sender_id],
      auth_id: message[:auth_id]
    )
  end
end
