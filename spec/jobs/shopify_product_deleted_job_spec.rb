# frozen_string_literal: true

RSpec.describe ShopifyProductDeletedJob, type: :job do
  let(:product) { create(:product) }
  subject(:perform) { described_class.perform_now(product_id: product.id.to_s) }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should delete product" do
    product
    expect { perform }.to change { Product.count }.by(-1)
  end
end
