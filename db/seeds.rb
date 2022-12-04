# seed talents
talents = []
10.times.each do |_|
  talents << User.create(name: Faker::Name.name)
end

# seed authors
authors = []
10.times.each do |_|
  authors << User.create(name: Faker::Name.name, author: true)
end

# seed courses
authors.each do |author|
  course = Course.new(name: Faker::Educator.course_name, author: author)
  course.talents = talents.sample(5)
  course.save
end
