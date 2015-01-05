module Todo

  class Command

    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      @argv=argv
    end

    def execute
      options=Options.parse!(@argv)
      DB.prepare
    end

    def create_task(name,content)
      Task.create!(name:name,content:content).reload
    end

    def delete_task(id)
      task= Task.find(id)
      task.destroy
    end

    def find_tasks(status_name)
      all_tasks=Task.order('created_at DESC')

      if status_name
        status=Task::STATUS.fetch(status_name.upcase)
        all_tasks.status_is(status)
      else
        all_tasks
      end
    end

    def update_task(id,attributes)
      if status_name=attributes[:status]
        attributes[:status]=Task::STATUS.fetch(status_name.upcase)
      end

      task=Task.find(id)
      task.update_attributes! attributes

      task.reload
    end

  end
end
