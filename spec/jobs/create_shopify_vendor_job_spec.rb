# frozen_string_literal: true

RSpec.describe CreateShopifyVendorJob, type: :job do
  let(:vendor) { create(:vendor) }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:business_name) { Faker::Company.name }
  let(:phone) { Faker::PhoneNumber.cell_phone }
  let(:tags) { [] }

  subject(:perform) do
    described_class.perform_now(
      vendor_id: vendor.id.to_s,
      first_name: first_name,
      last_name: last_name,
      business_name: business_name,
      email: vendor.user.email,
      phone: phone
    )
  end

  before(:each) do
    allow(Hutch).to receive(:connect)
    allow(Hutch).to receive(:publish)
  end

  it "should publish" do
    expect(Hutch).to receive(:publish).with("shopify.vendor.create", {
                                              sender_id: vendor.id.to_s,
                                              first_name: first_name,
                                              last_name: last_name,
                                              business_name: business_name,
                                              email: vendor.user.email,
                                              phone: phone,
                                              tags: tags
                                            }).exactly(1)

    perform
  end
end
