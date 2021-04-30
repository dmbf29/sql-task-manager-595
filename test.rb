require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# Read (1) - Test:
# task = Task.find(1)
# puts "#{task.title} - #{task.description}"

# # Create - Test:
# task = Task.new(title: 'drink beer in the park')
# puts "no id:"
# p task
# # task.save
# puts "should have id:"
# p task # The id of this new task, assigned automatically by SQLite

# # Update - Test:
# task = Task.find(3)
# task.title = 'Except for Ryan'
# task.save
# task = Task.find(3)
# puts task.title

p Task.all

# Destroy - Test:
# task = Task.find(3)
# task.destroy
# puts Task.find(3) == nil # Should output `true`
