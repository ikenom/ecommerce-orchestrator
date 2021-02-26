# frozen_string_literal: true

RSpec.describe CreateVendorJob, type: :job do
  let(:user) { create(:user) }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:business_name) { Faker::Company.name }
  let(:phone) { Faker::PhoneNumber.cell_phone }

  subject(:perform) { described_class.perform_now(user_id: user.id.to_s, first_name: first_name, last_name: last_name, business_name: business_name, phone: phone) }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should create vendor" do
    expect { perform }.to change { Vendor.count }.by(1)
  end

  it "should enqueue CreateShopifyVendorJob" do
    perform
    vendor = Vendor.last
    expect(CreateShopifyVendorJob).to have_been_enqueued.with({
                                                                vendor_id: vendor.id.to_s,
                                                                first_name: vendor.first_name,
                                                                last_name: vendor.last_name,
                                                                business_name: vendor.business_name,
                                                                email: vendor.user.email,
                                                                phone: vendor.phone
                                                              })
  end

  it "should enqueue CreateCmsVendorJob" do
    perform
    vendor = Vendor.last
    expect(CreateCmsVendorJob).to have_been_enqueued.with({
                                                            vendor_id: vendor.id.to_s, business_name: vendor.business_name
                                                          })
  end
end
