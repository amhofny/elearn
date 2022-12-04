# README

### System dependencies
- install Ruby version (2.7.2)
- install PostgresSQL
- `bundle install`

### Configuration
- change config/database.yml and add your username and password

### Database creation
- `rails db:create`

### Database initialization
- `rails db:seed`

### How to run the test suite
- `bundle exec rspec`
- import postman collection "elearn.postman_collection.json"

### Documentation
- run `rake rswag:specs:swaggerize`
- run `open http://localhost:3000/api-docs/`

### Deployment instructions
- get a linux server
- install ruby 2.7.2
- install nginx
- configure nginx server with passenger
- run `cap production deploy`
