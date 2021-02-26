# frozen_string_literal: true

RSpec.describe UserCreatedJob, type: :job do
  let(:user) { create(:user) }
  let(:auth_id) { Faker::Alphanumeric.alpha }

  subject(:perform) { described_class.perform_now(user_id: user.id.to_s, auth_id: auth_id) }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should update product" do
    expect(user.auth_id).to_not eq(auth_id)

    perform
    expect(user.reload.auth_id).to eq(auth_id)
  end
end
