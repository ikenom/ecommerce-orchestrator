class CreateUserJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_user

  def perform(email:, password:, display_name:)
    user = User.create!(email: email)
    CreateAuthUserJob.perform_later(user_id: user.id.to_s, password: password, display_name: display_name)
  end
end