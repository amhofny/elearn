require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  before(:each) { set_content_type }

  let!(:courses) { create_list(:course, 5) }
  let!(:course) { courses.first }
  let!(:author) { create(:user, :author) }
  let!(:talent) { create(:user, :talent) }

  describe 'GET /courses' do
    before { get :index }
    it 'returns courses' do
      count = Course.count
      expect(json_response).not_to be_empty
      expect(json_response['data'].size).to eq(count)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /courses/:id' do
    before { get :show, params: {id: course.id}}
    it "returns course" do
      expect(json_response).not_to be_empty
      expect(json_response["data"]).to have_attribute(:name).with_value(course.name)
    end
  end

  describe 'POST /course' do
    context 'when the request is valid' do
      let(:name) { 'Test Course' }
      let(:payload) do
        { data: {
          type: "courses", attributes: { name: name },
          relationships: {
            author: { data: { type: "authors", id: author.id }},
            talents: { data: [{ type: "talents", id: talent.id }]}
          }
        }}
      end
      before { post :create, params: payload }
      it 'creates course' do
        expect(json_response["data"]).to have_attribute(:name).with_value(name)
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:payload) { { data: { type: "courses", attributes: { name: "" } } }}
      before { post :create, params: payload }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /courses/:id' do
    before { delete :destroy, params: { id: course.id } }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
 end
