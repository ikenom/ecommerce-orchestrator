# frozen_string_literal: true

RSpec.describe CmsVendorCreatedConsumer do
  let(:vendor) { create(:vendor) }
  let(:message) do
    {
      cms_id: Faker::Alphanumeric.alpha,
      vendor_id: vendor.id.to_s
    }
  end

  subject(:consumer) { described_class.new }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should have correct queue name" do
    expect(described_class.get_queue_name).to eq("consumer_ecommerce_orchestrator_cms_vendor_created")
  end

  it "should enqueue shopify product created job" do
    consumer.process(message)
    expect(CmsVendorCreatedJob).to have_been_enqueued.with({
                                                             cms_id: message[:cms_id],
                                                             vendor_id: message[:sender_id]
                                                           })
  end
end
