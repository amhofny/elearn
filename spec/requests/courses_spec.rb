require 'swagger_helper'

RSpec.describe 'courses', type: :request do
  let!(:author_with_course) { create(:author_with_courses) }
  let!(:course) { author_with_course.authored_courses.first }
  let!(:talent) { create(:user, :talent) }

  path '/courses/{course_id}/relationships/author' do
    # You'll want to customize the parameter types...
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'

    get('show_relationship course') do
      let(:course_id) { course.id }

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

    patch('update_relationship course') do
      let(:course_id) { course.id }
      parameter name: :author, in: :body
      consumes "application/vnd.api+json"
      let(:author) {{ data: { type: "authors", id: author_with_course.id }}}

      response(204, 'successful') do
        run_test!
      end
    end

    delete('destroy_relationship course') do
      let(:course_id) { course.id }

      response(422, 'successful') do
        run_test!
      end
    end
  end

  path '/courses/{course_id}/relationships/talents' do
    # You'll want to customize the parameter types...
    parameter name: 'course_id', in: :path, type: :string, description: 'course_id'

    get('show_relationship course') do
      let(:course_id) { course.id }

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

    post('create_relationship course') do
      let(:course_id) { course.id }
      parameter name: :tal, in: :body
      consumes "application/vnd.api+json"
      let(:tal) {{ data: [{type: "talents", id: talent.id}]}}

      response(204, 'successful') do
        run_test!
      end
    end

    delete('destroy_relationship course') do
      let(:course_id) { course.id }
      parameter name: :tal, in: :body
      consumes "application/vnd.api+json"
      let(:tal) {{ data: [{type: "talents", id: course.talents.first.id}]}}

      response(204, 'successful') do
        run_test!
      end
    end
  end

  path '/courses' do

    get('list courses') do
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

    post('create course') do
      consumes "application/vnd.api+json"
      parameter name: :ucourse, in: :body, schema: { '$ref' => '#/components/schemas/object' }
      let(:ucourse) {{ data: {
        type: "courses", attributes: { name: "test" },
        relationships: {author: { data: { type: "authors", id: author_with_course.id }}}}
      }}

      response(201, 'successful') do
        run_test!
      end
    end
  end

  path '/courses/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show course') do
      let(:id) { course.id }

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

    patch('update course') do
      parameter name: :ucourse, in: :body, schema: { '$ref' => '#/components/schemas/object' }
      let(:id) { course.id }
      let(:ucourse) {{ data: { type: "courses",id: course.id, attributes: { name: "Test" } } }}
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

    put('update course') do
      parameter name: :ucourse, in: :body, schema: { '$ref' => '#/components/schemas/object' }
      let(:id) { course.id }
      let(:ucourse) {{ data: { type: "courses",id: course.id, attributes: { name: "Test" } } }}
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

    delete('delete course') do
      let(:id) { course.id }

      response(204, 'successful') do
        run_test!
      end
    end
  end

  path '/authors/{author_id}/courses' do
    parameter name: 'author_id', in: :path, type: :string, description: 'author_id'

    get('index_related_resources course') do
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
  end

  path '/talents/{talent_id}/courses' do
    parameter name: 'talent_id', in: :path, type: :string, description: 'talent_id'

    get('index_related_resources course') do
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
  end
end
