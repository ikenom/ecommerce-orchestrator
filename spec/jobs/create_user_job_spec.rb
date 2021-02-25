# frozen_string_literal: true

RSpec.describe CreateUserJob, type: :job do
  let(:email) { Faker::Internet.email }
  let(:display_name) { Faker::Superhero.name }
  let(:password) { Faker::Alphanumeric.alpha }

  subject(:perform) { described_class.perform_now(email: email, display_name: display_name, password: password) }

  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it "should create user" do
    expect { perform }.to change { User.count }.by(1)
  end

  it "should enqueue CreateAuthUserJob" do
    perform
    user = User.last
    expect(CreateAuthUserJob).to have_been_enqueued.with({
                                                           user_id: user.id.to_s,
                                                           password: password,
                                                           display_name: display_name
                                                         })
  end
end
