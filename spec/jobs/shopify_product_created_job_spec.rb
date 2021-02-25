# frozen_string_literal: true

RSpec.describe ShopifyProductCreatedJob, type: :job do
  let(:product) { create(:product) }
  let(:shopify_id) { Faker::Alphanumeric.alpha }

  subject(:perform) { described_class.perform_now(product_id: product.id.to_s, shopify_id: shopify_id) }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should update product" do
    expect(product.shopify_id).to_not eq(shopify_id)

    perform
    expect(product.reload.shopify_id).to eq(shopify_id)
  end
end
