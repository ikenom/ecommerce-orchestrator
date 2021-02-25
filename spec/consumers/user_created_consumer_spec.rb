# frozen_string_literal: true

RSpec.describe UserCreatedConsumer do
  let(:message) do
    {
      sender_id: Faker::Alphanumeric.alpha,
      auth_id: Faker::Alphanumeric.alpha
    }
  end

  subject(:consumer) { described_class.new }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should have correct queue name" do
    expect(described_class.get_queue_name).to eq("consumer_ecommerce_orchestrator_user_created")
  end

  it "should enqueue user created job" do
    consumer.process(message)
    expect(UserCreatedJob).to have_been_enqueued.with({
                                                        user_id: message[:sender_id],
                                                        auth_id: message[:auth_id]
                                                      })
  end
end
