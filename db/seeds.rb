require "open-uri"

puts "Cleaning database"
User.destroy_all
Goal.destroy_all
Task.destroy_all

nicknames = %w[pockie pink_monster warrior ice_man maverick]
files = %w[https://images.unsplash.com/photo-1660949632684-3fdb4a515185?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80
           https://images.unsplash.com/photo-1660983366226-cf167690e167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60
           https://images.unsplash.com/photo-1659038129553-1777827549de?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDZ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60
           https://images.unsplash.com/photo-1659644242353-0a8f3c3e9ecf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60
           https://images.unsplash.com/photo-1584720175631-f9d3633a2e78?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80]

goals = ["Find a career that I love 🤓", "Learn how to dance", "Visit all of the Colombian national parks", "Improve my public speaking skills", "Go to Paris 🗼"]
categories = ["professional growth", "hobbies", "traveling", "personal growth", "dreams"]
tasks = ["Search for universities", "Go to the bachata dancing classes", "Save enough money for the tickets", "Taking part in conversations or roleplay", "Get a valid passport"]

puts "Creating Katapi Users 🎈🌿"
5.times do |num|
  user = User.new(
    email: Faker::Internet.email,
    password: "123456",
    nickname: nicknames[num]
  )
  file = URI.open(files[num])
  user.photo.attach(io: file, filename: "avatar.png", content_type: "image/png")
  user.save
end

puts "Creating Goals ✨⚡💖"
5.times do |num|
  goal = Goal.new(
    name: goals[num - 1],
    category: categories[num - 1],
    maturity: 0,
    user_id: num + 1
  )
  goal.save
end

puts "Creating tasks 🧛‍♂️"
5.times do |num|
  year = rand(2022..2025)
  month = rand(1..12)
  day = rand(1..30)

  task = Task.new(
    name: tasks[num - 1],
    status: 0,
    priority: 0,
    difficulty: 0,
    due_date: Date.new(year, month, day),
    goal_id: num + 1
  )
  task.save
end

puts "Bye-bye! ✨🎃"
