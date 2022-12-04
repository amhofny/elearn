require 'rails_helper'

RSpec.describe TalentsController, type: :controller do
  before(:each) { set_content_type }

  let!(:talents) { create_list(:user, 5, :talent) }
  let!(:talent) { talents.first }

  describe 'GET /talents' do
    before { get :index }
    it 'returns talents' do
      count = User.count
      expect(json_response).not_to be_empty
      expect(json_response['data'].size).to eq(count)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /talents/:id' do
    before { get :show, params: {id: talent.id}}
    it "returns talent" do
      expect(json_response).not_to be_empty
      expect(json_response["data"]).to have_attribute(:name).with_value(talent.name)
    end
  end

  describe 'POST /talent' do
    context 'when the request is valid' do
      let(:name) { 'Test Talent' }
      let(:payload) { { data: { type: "talents", attributes: { name: name } } }}
      before { post :create, params: payload }
      it 'creates talent' do
        expect(json_response["data"]).to have_attribute(:name).with_value(name)
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:payload) { { data: { type: "talents", attributes: { name: "" } } }}
      before { post :create, params: payload }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /talents/:id' do
    before { delete :destroy, params: { id: talent.id } }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
 end
