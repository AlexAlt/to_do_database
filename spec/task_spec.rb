require('spec_helper')

describe(Task) do

  describe('#==') do
    it('is the same task if it has the same description') do
      task1 = Task.new({:description => 'learn SQL', :list_id => 1})
      task2 = Task.new({:description => 'learn SQL', :list_id => 1})
      expect(task1).to(eq(task2))
    end
  end

  describe('#save') do
    it('adds task to the array of saved tasks') do
      test_task = Task.new({:description => 'learn SQL', :list_id => 1})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe('#description') do
    it('lets you add give a description of a task') do
      test_task = Task.new({:description => 'learn SQL', :list_id => 1})
      expect(test_task.description()).to(eq('learn SQL'))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#id") do
    it("lets you read the ID out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      test_task.save()
      expect(test_task.id()).to(be_an_instance_of(Fixnum))
    end
  end
  # describe('#save') do
  #   it('adds a task to a list of saved tasks') do
  #     test_task = Task.new("put your hat on")
  #     test_task.save()
  #     expect(Task.all()).to(eq([test_task]))
  #   end
  # end

  # describe('.clear') do
  #   it('empties out all of the saved tasks') do
  #     Task.new({:description => 'learn SQL'}).save()
  #     Task.clear()
  #     expect(Task.all()).to(eq([]))
  #   end
  # end
end
