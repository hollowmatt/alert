# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Admin User
unless User.exists?(email: "admin@gmail.com")
  users = User.create!(email: "admin@gmail.com", password: 'password', admin: true)
end

# Non-Admin User
unless User.exists?(email: 'ima_user@gmail.com')
  users = User.create!(email: 'ima_user@gmail.com', password: 'welcome99', admin: false)
end

# Manager User
unless User.exists?(email: 'nip@nap.com')
	users = User.create!(email: 'nip@nap.com', password: 'welcome99', admin: false)
end

# NOOK Press Brannigan
unless Platform.exists?(name: 'Brannigan')
  platforms = Platform.create!(name: 'Brannigan', description: 'NOOK Press eBook platform UI')
end

# NPS
unless Platform.exists?(name: 'NPS')
	platforms = Platform.create!(name: 'NPS', description: 'NOOK Press Services platform')
end

# Status
unless Status.exists?(name: 'New')
	statuses = Status.create!(name: 'New', color: 'red')
end

unless Status.exists?(name: 'In Progress')
	statuses = Status.create!(name: 'In Progress', color: 'orange')
end

unless Status.exists?(name: 'Resolved')
	statuses = Status.create!(name: 'Resolved', color: 'blue')
end

unless Status.exists?(name: 'Closed')
	statuses = Status.create!(name: 'Closed', color: 'green')
end

unless Priority.exists?(name: "P1")
	priorities = Priority.create!(name: 'P1')
end

unless Priority.exists?(name: "P2")
	priorities = Priority.create!(name: 'P2')
end

unless Priority.exists?(name: "P3")
	priorities = Priority.create!(name: 'P3')
end
