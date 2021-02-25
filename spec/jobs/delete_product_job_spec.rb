# frozen_string_literal: true

RSpec.describe DeleteProductJob, type: :job do
  let(:product) { create(:product) }

  subject(:perform) {
    described_class.perform_now(cms_id: product.cms_id)
  }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should enqueue DeleteShopifyProductJob" do
    perform
    product = Product.last
    expect(DeleteShopifyProductJob).to have_been_enqueued.with({
                                                           product_id: product.id.to_s,
                                                         })
  end
end
