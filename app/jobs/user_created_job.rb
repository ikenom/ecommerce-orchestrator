# frozen_string_literal: true

class UserCreatedJob < ApplicationJob
  queue_as :ecommerce_orchestrator_user_created

  def perform(user_id:, auth_id:)
    user = User.find(user_id)
    user.auth_id = auth_id
    user.save!
  end
end
