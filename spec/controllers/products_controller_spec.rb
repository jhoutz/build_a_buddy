require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      item = Item.new
      sa = StuffedAnimal.create(description: 'Bear')
      item.build_item_product(product: sa)
      item.save
      get :show, params: { id: item.id }
      expect(response).to be_success
    end
  end
end
