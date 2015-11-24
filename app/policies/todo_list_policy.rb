class TodoListPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @todo_list = model
  end

  def index?
    true
  end

  def show?
    @current_user == @todo_list.user
  end

  def new?
    true
  end

  def edit?
    @current_user == @todo_list.user
  end

  def create?
    true
  end

  def update?
    @current_user == @todo_list.user
  end

  def destroy?
    @current_user == @todo_list.user
  end
end
