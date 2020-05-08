FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Pedido nº #{n}" }

    # association :customer, factory: :user
    customer
  end
end
