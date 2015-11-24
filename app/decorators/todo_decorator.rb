class TodoDecorator < Draper::Decorator
  delegate_all

  def completion_status
    if is_completed?
      "Completed :-)"
    else
      "Not completed :-("
    end
  end

  def created_at
    object.created_at.strftime("%A, %B %e")
  end
end
