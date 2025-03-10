require 'faker'

# YOURE ON STEP 4!!!!!!!!

#Admin
admin = User.create(
    name: "Admin",
    email: "admin@csg.com",
    password: "admincsg", 
    password_confirmation: "admincsg",
    role: "admin"
  )
  

#User
10.times do 
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email(domain: 'gmail.com'),
    password: "passwordtest", 
    password_confirmation: "passwordtest",
    role: "user"
  )
end

User.all.each do |user|
  3.times do  # Each user gets 3 teams
    user.teams.create(name: Faker::Sports::Rugby.team) 
  end
end

Team.all.each do |team|
  5.times do # Each team gets 7 players
    team.players.create(name: Faker::Sports::Rugby.player) 
  end
end