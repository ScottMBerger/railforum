User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             username: "ExampleUser",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  username =  "user#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               username: username,
               email: email,
               password:              password,
               password_confirmation: password)
end