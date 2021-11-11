User.destroy_all

john_doe = User.create!(email: "john.doe@flatstack.com", first_name: "John", last_name: "Doe", password: "123456")

darth_vader = User.create!(
  email: "darth.vader@flatstack.com",
  first_name: "Darth",
  last_name: "Vader",
  password: "123456"
)
