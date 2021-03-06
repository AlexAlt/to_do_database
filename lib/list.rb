class List
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_list|
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end

  define_method(:tasks) do
    returned_tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id}")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch('description')
      id = task.fetch('id').to_i()
      list_id = task.fetch('list_id').to_i()
      tasks.push(Task.new({:id => id, :description => description, :list_id => list_id}))
    end
    tasks
  end

  define_method(:add_tasks) do |task|
    task.list_id = @id
    DB.exec("UPDATE tasks SET list_id = #{@id} WHERE id = #{task.id()};")
  end
  define_singleton_method(:find) do |ident|
    found_list = nil

    List.all().each() do |list|
      if list.id().==(ident)
        found_list = list
      end
    end
    found_list
  end
end
