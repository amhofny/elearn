require 'swagger_helper'

RSpec.describe 'authors', type: :request do
  let!(:author_with_course) { create(:author_with_courses) }
  let!(:author_no_course) { create(:user, :author) }

  path '/courses/{course_id}/author' do
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'

    get('show_related_resource author') do
      let(:course_id) { author_with_course.authored_courses.first.id }

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

  path '/authors/{author_id}/relationships/courses' do
    parameter name: 'author_id', in: :path, type: :string, description: 'author_id'

    get('show_relationship author') do
      let(:author_id) { author_with_course.id }

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

    post('create_relationship author') do
      let(:author_id) { author_with_course.id }
      parameter name: :course, in: :body
      consumes "application/vnd.api+json"
      let(:course) {
        { data: [{type: "courses", id: author_with_course.authored_courses.first.id}]}
      }

      response(204, 'successful') do
        run_test!
      end
    end
  end

  path '/authors' do

    get('list authors') do
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

    post('create author') do
      parameter name: :new_author, in: :body,
                schema: { '$ref' => '#/components/schemas/new_object' }
      consumes "application/vnd.api+json"
      let(:new_author) {{ data: { type: "authors", attributes: { name: "Test" } } }}

      response(201, 'successful') do
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

  path '/authors/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show author') do
      let(:id) { author_with_course.id }
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

    patch('update author') do
      parameter name: :author, in: :body, schema: { '$ref' => '#/components/schemas/object' }
      let(:id) { author_with_course.id }
      let(:author) {
        { data: { type: "authors", id: author_with_course.id, attributes: { name: "Test" } } }
      }
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

    put('update author') do
      parameter name: :author, in: :body, schema: { '$ref' => '#/components/schemas/object' }
      let(:id) { author_with_course.id }
      let(:author) {
        { data: { type: "authors",id: author_with_course.id, attributes: { name: "Test" } } }
      }
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

    delete('delete author') do
      let(:id) { author_no_course.id }

      response(204, 'successful') do
        run_test!
      end
    end
  end
end
