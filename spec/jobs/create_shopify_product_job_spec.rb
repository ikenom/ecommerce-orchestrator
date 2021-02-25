# frozen_string_literal: true

RSpec.describe CreateShopifyProductJob, type: :job do
  let(:product) { create(:product) }
  let(:price) { Faker::Commerce.price(range: 0..10.0, as_string: true) }
  let(:name) { Faker::Restaurant.name }
  let(:type) { Faker::Restaurant.type }
  let(:tags) { [] }

  subject(:perform) do
    described_class.perform_now(
      product_id: product.id.to_s,
      name: name,
      type: type,
      price: price,
      tags: tags
    )
  end

  before(:each) do
    allow(Hutch).to receive(:connect)
    allow(Hutch).to receive(:publish)
  end

  it "should publish" do
    expect(Hutch).to receive(:publish).with("shopify.product.create", {
                                              sender_id: product.id.to_s,
                                              vendor_id: product.vendor.shopify_id,
                                              product_type: type,
                                              product_name: name,
                                              price: price,
                                              tags: tags
                                            }).exactly(1)

    perform
  end
end
