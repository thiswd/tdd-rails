require 'rails_helper'
require_relative '../support/new_customer_form'

RSpec.feature "Customers", type: :feature, js: true do
  let(:member) { create(:member) }

  it 'visit index page' do
    visit(customers_path)
    # Inspecionar o html
    # print page.html
    # salva um página acessada em tmp
    # save_and_open_page
    # page.save_screenshot('customers_index.png')
    expect(page).to have_current_path(customers_path)
  end

  it 'ajax' do
    visit(customers_path)
    click_link('Add Message')
    expect(page).to have_content('Yes!')
  end

  it 'find' do
    visit(customers_path)
    click_link('Add Message')
    expect(find('#my-div').find('h1')).to have_content('Yes!')
  end

  it 'creates a customer - page object pattern' do
    new_customer_form = NewCustomerForm.new
    new_customer_form.login.visit_page.fill_in_with({
      name: Faker::Name.name,
      email: Faker::Internet.email
    }).submit

    expect(page).to have_content('Customer was successfully created.')
  end

  it 'creates a customer' do
    login_as(member, scope: :member)
    visit(new_customer_path)
    # fill_in(<label>)
    fill_in('Name', with: Faker::Name.name)
    fill_in('Email', with: Faker::Internet.email)
    fill_in('Address', with: Faker::Address.street_address)
    click_button('Create Customer')

    expect(page).to have_content('Customer was successfully created.')
  end
end
