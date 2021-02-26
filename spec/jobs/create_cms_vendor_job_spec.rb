# frozen_string_literal: true

RSpec.describe CreateCmsVendorJob, type: :job do
  let(:business_name) { Faker::Restaurant.name }
  let(:vendor) { create(:vendor) }

  subject(:perform) { described_class.perform_now(vendor_id: vendor.id.to_s, business_name: business_name) }

  before(:each) do
    allow(Hutch).to receive(:connect)
    allow(Hutch).to receive(:publish)
  end

  it "should publish" do
    expect(Hutch).to receive(:publish).with("cms.vendor.create", {
                                              sender_id: vendor.id.to_s,
                                              name: business_name
                                            }).exactly(1)

    perform
  end
end
