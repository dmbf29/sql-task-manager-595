# setup the class w/sql statements
class Task
  attr_reader :id, :description
  attr_accessor :title

  def initialize(attributes = {})
    @id = attributes[:id] || attributes['id']
    @title = attributes[:title] || attributes['title']
    @description = attributes[:description] || attributes['description']
    @done = attributes[:done] == 1 || attributes['done'] == 1
  end

  def done?
    @done
  end

  def self.all
    tasks = DB.execute('SELECT * FROM tasks')
    tasks.map do |attributes|
      Task.new(attributes)
    end
  end

  def self.find(id)
    # there is no instance. so no instance variables
    task = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
    Task.new(task) if task
  end

  def save
    @id ? update : create
  end

  def create
    query = <<-SQL
    INSERT INTO tasks (title, description, done)
    VALUES (?, ?, ?)
    SQL

    DB.execute(query, @title, @description, @done ? 1 : 0)
    @id = DB.last_insert_row_id
  end

  def update
    done = @done ? 1 : 0
    DB.execute('UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?', @title, @description, done, id)
  end

  def destroy
    DB.execute('DELETE FROM tasks WHERE id = ?', id)
  end

end
