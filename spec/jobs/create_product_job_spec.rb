# frozen_string_literal: true

RSpec.describe CreateProductJob, type: :job do
  let(:vendor) { create(:vendor) }
  let(:cms_id) { Faker::Alphanumeric.alpha }
  let(:name) { Faker::Name.name }
  let(:price) { Faker::Commerce.price(range: 0..10.0, as_string: true) }
  let(:type) { "Product" }

  subject(:perform) {
    described_class.perform_now(
      vendor_id: vendor.id.to_s,
      cms_id: cms_id,
      price: price,
      name: name,
      type: type)
  }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should create product" do
    expect { perform }.to change { Product.count }.by(1)
  end

  it "should enqueue CreateShopifyProductJob" do
    perform
    product = Product.last
    expect(CreateShopifyProductJob).to have_been_enqueued.with({
                                                           product_id: product.id.to_s,
                                                           price: price,
      name: name,
      type: type,
      tags: ["cms_id:#{cms_id}"]
                                                         })
  end
end
