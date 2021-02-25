# frozen_string_literal: true

RSpec.describe UpdateShopifyProductJob, type: :job do
  let(:product) { create(:product) }
  let(:name) { Faker::Food.dish }
  let(:price) { Faker::Commerce.price(range: 0..10.0, as_string: true) }
  let(:tags) { [] }

  subject(:perform) do
    described_class.perform_now(
      product_id: product.id.to_s,
      name: name,
      price: price
    )
  end

  before(:each) do
    allow(Hutch).to receive(:connect)
    allow(Hutch).to receive(:publish)
  end

  it "should publish" do
    expect(Hutch).to receive(:publish).with("shopify.product.update", {
                                              sender_id: product.id.to_s,
                                              product_id: product.shopify_id,
                                              product_name: name,
                                              price: price,
                                              tags: tags
                                            }).exactly(1)

    perform
  end
end
