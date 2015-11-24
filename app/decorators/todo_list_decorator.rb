class TodoListDecorator < Draper::Decorator
  delegate_all

  def title
    object.name
  end

  def completion_status
    if object.todos.where(is_completed: false).exists?
      "Not all completed :-("
    else
      "All completed!"
    end
  end

  def created_at
    object.created_at.strftime("%A, %B %e")
  end
end
