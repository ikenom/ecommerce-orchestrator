# frozen_string_literal: true

RSpec.describe ShopifyVendorCreatedConsumer do
  let(:message) do
    {
      sender_id: Faker::Alphanumeric.alpha,
      shopify_id: Faker::Alphanumeric.alpha
    }
  end

  subject(:consumer) { described_class.new }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should have correct queue name" do
    expect(described_class.get_queue_name).to eq("consumer_ecommerce_orchestrator_shopify_vendor_created")
  end

  it "should enqueue shopify product created job" do
    consumer.process(message)
    expect(ShopifyEntityCreatedJob).to have_been_enqueued.with({
                                                                 entity_id: message[:sender_id],
                                                                 shopify_id: message[:shopify_id]
                                                               })
  end
end
