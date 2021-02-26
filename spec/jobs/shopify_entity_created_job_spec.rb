# frozen_string_literal: true

RSpec.describe ShopifyEntityCreatedJob, type: :job do
  let(:entity) { create(:shopify_entity) }
  let(:shopify_id) { Faker::Alphanumeric.alpha }

  subject(:perform) { described_class.perform_now(entity_id: entity.id.to_s, shopify_id: shopify_id) }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should update product" do
    expect(entity.shopify_id).to_not eq(shopify_id)

    perform
    expect(entity.reload.shopify_id).to eq(shopify_id)
  end
end
