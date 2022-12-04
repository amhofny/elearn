require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  before(:each) { set_content_type }

  let!(:authors) { create_list(:user, 5, :author) }
  let!(:author) { authors.first }
  let!(:author_with_course) { create(:author_with_courses) }

  describe 'GET /authors' do
    before { get :index }
    it 'returns authors' do
      count = User.authors.count
      expect(json_response).not_to be_empty
      expect(json_response['data'].size).to eq(count)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /authors/:id' do
    before { get :show, params: {id: author.id}}
    it "returns author" do
      expect(json_response).not_to be_empty
      expect(json_response["data"]).to have_attribute(:name).with_value(author.name)
    end
  end

  describe 'POST /author' do
    context 'when the request is valid' do
      let(:name) { 'Test Author' }
      let(:payload) { { data: { type: "authors", attributes: { name: name } } }}
      before { post :create, params: payload }
      it 'creates author' do
        expect(json_response["data"]).to have_attribute(:name).with_value(name)
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:payload) { { data: { type: "authors", attributes: { name: "" } } }}
      before { post :create, params: payload }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /authors/:id' do
    context "when author doesn't have courses" do
      before { delete :destroy, params: { id: author.id } }
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context "when author has course" do
      before { delete :destroy, params: { id: author_with_course.id } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
 end
