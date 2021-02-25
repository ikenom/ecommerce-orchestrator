# frozen_string_literal: true

RSpec.describe UpdateProductJob, type: :job do
  let(:product) { create(:product) }
  let(:name) { Faker::Food.dish }
  let(:price) { Faker::Commerce.price(range: 0..10.0, as_string: true) }

  subject(:perform) do
    described_class.perform_now(
      cms_id: product.cms_id,
      price: price,
      name: name
    )
  end

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should enqueue UpdateShopifyProductJob" do
    perform
    product = Product.last
    expect(UpdateShopifyProductJob).to have_been_enqueued.with({
                                                                 product_id: product.id.to_s,
                                                                 price: price,
                                                                 name: name,
                                                               })
  end
end
