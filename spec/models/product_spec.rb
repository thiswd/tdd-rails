require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create(:product) }
  let(:invalid_product) { build(:product, description: nil) }

  it 'is valid with description, price and category' do
    expect(product).to be_valid
  end

  # it 'is invalid without description' do
  #   expect(invalid_product).not_to be_valid
  #   invalid_product.valid?
  #   expect(invalid_product.errors[:description]).to include("can't be blank")
  # end

  context 'Validates' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { should validate_presence_of(:category) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:category) }
  end

  context 'Instance methods' do
    it '#full_description' do
      expect(product.full_description).to eq(
        "R$ #{product.price} - #{product.description}"
      )
    end
  end
end
