# frozen_string_literal: true

RSpec.describe ShopifyProductDeletedConsumer do
  let(:message) do
    {
      sender_id: Faker::Alphanumeric.alpha,
    }
  end

  subject(:consumer) { described_class.new }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should have correct queue name" do
    expect(described_class.get_queue_name).to eq("consumer_ecommerce_orchestrator_shopify_product_deleted")
  end

  it "should enqueue shopify product created job" do
    consumer.process(message)
    expect(ShopifyProductDeletedJob).to have_been_enqueued.with({
                                                                  product_id: message[:sender_id],
                                                                })
  end
end
