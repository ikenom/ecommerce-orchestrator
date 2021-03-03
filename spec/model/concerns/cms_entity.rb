# frozen_string_literal: true

RSpec.describe Product, type: :model do
  subject { build(:product) }

  describe "validations" do
    it { is_expected.to have_field(:cms_id).of_type(String) }
    it { is_expected.to have_index_for(cms_id: 1) }
  end
end
