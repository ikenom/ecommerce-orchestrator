# frozen_string_literal: true

RSpec.describe CmsVendorCreatedJob, type: :job do
  let(:vendor) { create(:vendor) }
  let(:cms_id) { Faker::Alphanumeric.alpha }

  subject(:perform) { described_class.perform_now(vendor_id: vendor.id.to_s, cms_id: cms_id) }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should update product" do
    expect(vendor.cms_id).to_not eq(cms_id)

    perform
    expect(vendor.reload.cms_id).to eq(cms_id)
  end
end
