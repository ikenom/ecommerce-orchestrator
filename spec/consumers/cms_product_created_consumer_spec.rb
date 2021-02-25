# frozen_string_literal: true

RSpec.describe CmsProductCreatedConsumer do
  let(:message) do
    {
      cms_id: Faker::Alphanumeric.alpha,
      name: Faker::Name.name,
      price: Faker::Commerce.price(range: 0..10.0, as_string: true),
      type: "Product"
    }
  end

  subject(:consumer) { described_class.new }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should have correct queue name" do
    expect(described_class.get_queue_name).to eq("consumer_ecommerce_orchestrator_cms_product_created")
  end

  it "should enqueue shopify product created job" do
    consumer.process(message)
    expect(CreateProductJob).to have_been_enqueued.with({
      cms_id: message[:cms_id],
      name: message[:name],
      price: message[:price],
      type: message[:type]
                                                      })
  end
end
