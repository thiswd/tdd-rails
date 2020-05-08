require 'rails_helper'

RSpec.describe Customer, type: :model do
  # fixtures :customers
  # fixtures :all
  it '#full_name' do
    # usando fixtures
    # customer = customers(:thiago)
    customer = create(:customer, name: "Thiago Sawada") # Subrescrevendo attributo
    expect(customer.full_name).to start_with("Sr. Thiago Sawada")
  end

  it 'Herança - #vip' do
    customer = build(:customer_vip)
    expect(customer.vip).to be_truthy
  end

  it { expect {
    create(:user) # ou create(:customer)
  }.to change(Customer, :count).by(1) }

  it 'Usando attributes_for' do
    attrs = attributes_for(:customer)
    expect(attrs[:email]).to match(/..@../)
  end

  it 'Atributo Transitório' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Cliente Masculino VIP' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to be_truthy
  end

  it 'Cliente Feminina Padrão' do
    customer = create(:customer_female_default)
    expect(customer.gender).to eq('F')
    expect(customer.vip).to be_falsey
  end

  it 'travel_to' do 00
    travel_to Time.zone.local(2004, 11, 24, 00, 00, 00) do
      @customer = create(:customer_vip)
    end
    expect(@customer.created_at.year).to eq(2004)
  end
end
