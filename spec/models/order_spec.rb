require 'rails_helper'

RSpec.describe Order, type: :model do
  it "belongs_to" do
    order = create(:order)
    expect(order.customer).to be_kind_of(Customer)
  end

  it 'Tem 3 pedidos - create_list' do
    customer = build(:customer)
    orders = create_list(:order, 3, customer: customer)
    expect(orders.count).to eq(3)
  end

  it 'Tem 2 pedidos - create_pair' do
    orders = create_pair(:order)
    expect(orders.count).to eq(2)
  end

  it 'has_many' do
    customer = create(:customer, :with_orders, qtt_orders: 5)
    expect(customer.orders.count).to eq(5)
  end
end
