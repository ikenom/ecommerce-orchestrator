# frozen_string_literal: true

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:email) }
  end
end
