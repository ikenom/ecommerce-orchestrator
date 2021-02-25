# frozen_string_literal: true

RSpec.describe CmsProductUpdatedConsumer do
  let(:message) do
    {
      cms_id: Faker::Alphanumeric.alpha,
      name: Faker::Restaurant.name,
      price: Faker::Commerce.price(range: 0..10.0, as_string: true),
    }
  end

  subject(:consumer) { described_class.new }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should have correct queue name" do
    expect(described_class.get_queue_name).to eq("consumer_ecommerce_orchestrator_cms_product_updated")
  end

  it "should enqueue shopify product created job" do
    consumer.process(message)
    expect(UpdateProductJob).to have_been_enqueued.with({
                                                          cms_id: message[:cms_id],
                                                          name: message[:name],
                                                          price: message[:price],
                                                        })
  end
end
