# frozen_string_literal: true

RSpec.describe DeleteShopifyProductJob, type: :job do
  let(:product) { create(:product) }

  subject(:perform) {
    described_class.perform_now(product_id: product.id.to_s) }

  before(:each) do
    allow(Hutch).to receive(:connect)
    allow(Hutch).to receive(:publish)
  end

  it "should publish" do
    expect(Hutch).to receive(:publish).with("shopify.product.delete", {
                                              sender_id: product.id.to_s,
                                              product_id: product.shopify_id,
                                            }).exactly(1)

    perform
  end
end
