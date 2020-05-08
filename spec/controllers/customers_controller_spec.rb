require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:customer) { create(:customer) }
  let(:member) { create(:member) }
  let(:customer_params) { attributes_for(:customer) }

  context 'as a guest' do
    it 'responds successfully' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'responds a 302 (not authorized)' do
      get :show, params: { id: customer.id }
      expect(response).to have_http_status(302)
    end

    it 'route' do
      is_expected.to route(:get, '/customers').to(action: :index)
    end
  end

  context 'as logged member' do
    before { sign_in(member) }

    it 'content-type - json' do
      get :create, format: :json, params: { customer: customer_params }
      expect(response.content_type).to start_with('application/json')
    end

    it 'flash notice' do
      post :create, params: { customer: customer_params }
      expect(flash[:notice]).to match(/successfully created/)
    end

    it 'with valid attributes' do
      expect {
        post :create, params: { customer: customer_params } # Precisa da chave customer
      }.to change(Customer, :count).by(1)
    end

    it 'with invalid attributes' do
      invalid_customer_params = attributes_for(:customer, address: nil)
      expect {
        post :create, params: { customer: invalid_customer_params }
      }.not_to change(Customer, :count)
    end

    it 'responds status 200' do
      get :show, params: { id: customer.id }
      expect(response).to have_http_status(200)
    end

    it 'render :show template' do
      get :show, params: { id: customer.id }
      expect(response).to render_template(:show)
    end
  end
end
