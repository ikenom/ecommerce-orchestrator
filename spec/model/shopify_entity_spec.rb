# frozen_string_literal: true

RSpec.describe Product, type: :model do
  subject { build(:product) }

  describe "validations" do
    it { is_expected.to be_mongoid_document }
    it { is_expected.to be_valid }

    it { is_expected.to have_field(:shopify_id).of_type(String) }
    it { is_expected.to have_index_for(shopify_id: 1) }
  end
end
