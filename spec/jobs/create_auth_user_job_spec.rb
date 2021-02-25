# frozen_string_literal: true

RSpec.describe CreateAuthUserJob, type: :job do
  let(:user) { create(:user) }
  let(:display_name) { Faker::Superhero.name }
  let(:password) { Faker::Alphanumeric.alpha }

  subject(:perform) { described_class.perform_now(user_id: user.id.to_s, display_name: display_name, password: password) }

  before(:each) do
    allow(Hutch).to receive(:connect)
    allow(Hutch).to receive(:publish)
  end

  it "should publish" do
    expect(Hutch).to receive(:publish).with("user.create", {
                                              sender_id: user.id.to_s,
                                              email: user.email,
                                              password: password,
                                              display_name: display_name
                                            }).exactly(1)

    perform
  end
end
