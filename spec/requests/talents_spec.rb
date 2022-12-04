require 'swagger_helper'

RSpec.describe 'talents', type: :request do
  let!(:talent) { create(:user, :talent) }
  let!(:new_course) { create(:course) }

  path '/courses/{course_id}/talents' do
    parameter name: 'course_id', in: :path, type: :integer, description: 'course_id'

    get('index_related_resources talent') do
      let(:course_id) { new_course.id }

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/talents/{talent_id}/relationships/courses' do
    parameter name: 'talent_id', in: :path, type: :string, description: 'talent_id'

    get('show_relationship talent') do
      let(:talent_id) { talent.id }

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create_relationship talent') do
      let(:talent_id) { talent.id }
      parameter name: :course, in: :body
      consumes "application/vnd.api+json"
      let(:course) {
        { data: [{type: "courses", id: new_course.id}]}
      }

      response(204, 'successful') do
        run_test!
      end
    end
  end

  path '/talents' do

    get('list talents') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create talent') do
      parameter name: :new_talent, in: :body, schema: { '$ref' => '#/components/schemas/new_object' }
      consumes "application/vnd.api+json"
      let(:new_talent) {{ data: { type: "talents", attributes: { name: "Test" } } }}

      response(201, 'successful') do
        run_test!
      end
    end
  end

  path '/talents/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show talent') do
      response(200, 'successful') do
        let(:id) { talent.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update talent') do
      parameter name: :tal, in: :body, schema: { '$ref' => '#/components/schemas/object' }
      let(:id) { talent.id }
      let(:tal) {{ data: { type: "talents",id: talent.id, attributes: { name: "Test" } } }}
      consumes "application/vnd.api+json"

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update talent') do
      parameter name: :tal, in: :body, schema: { '$ref' => '#/components/schemas/object' }
      let(:id) { talent.id }
      let(:tal) {{ data: { type: "talents",id: talent.id, attributes: { name: "Test" } } }}
      consumes "application/vnd.api+json"

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete talent') do
      let(:id) { talent.id }

      response(204, 'successful') do
        run_test!
      end
    end
  end
end
