class CreateAuthUserJob < ApplicationJob
  queue_as :ecommerce_orchestrator_create_auth_user

  def perform(user_id:, password:, display_name:)
    Hutch.connect

    user = User.find(user_id)
    Hutch.publish("user.create",
      sender_id: user.id.to_s,
      email: user.email,
      password: password,
      display_name: display_name)
  end
end