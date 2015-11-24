class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [:index, :create, :update, :update_many, :destroy, :destroy_many, :status]

  def index
    respond_with(load_todos)
  end

  def create
    todo = Todo.belonging_to(session_user).create(todo_params)
    ws_service('todo:create', todo) if todo.errors.blank?
    load_and_render_index
  end

  def update
    # cheat - sometimes the blur event handler asks to update an already destroyed record.
    todos = Todo.belonging_to(session_user).where(id: params[:id])
    todo = todos.first
    todos.update_all(todo_params)
    ws_service('todo:update', todo) if todo
    load_and_render_index
  end

  def update_many
    Todo.belonging_to(session_user).where(id: params[:ids]).update_all(todo_params)
    ws_service('todo:update_many')
    load_and_render_index
  end

  def destroy
    # same problem as on update - sometimes we try to destroy twice in the JS
    todo = Todo.belonging_to(session_user).find_by(id: params[:id]).try(:destroy)
    ws_service('todo:destroy', todo) if todo && todo.destroyed?
    load_and_render_index
  end

  def destroy_many
    Todo.belonging_to(session_user).where(id: params[:ids]).try(:destroy_all)
    ws_service('todo:destroy_many')
    load_and_render_index
  end

  private

  def ws_service(event, data = {})
    @ws_service ||= WsService.new(@todo_list)
    @ws_service.call(event, data = {})
  end

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def todo_params
    params.require(:todo).permit(:title, :is_completed, :todo_list_id).merge(todo_list_id: @todo_list.id)
  end

  def filtering_params
    params.slice(:completed)
  end
  helper_method :filtering_params

  def load_and_render_index
    load_todos
    render :index, change: "todos"
  end

  def load_todos
    @todos = Todo.belonging_to(session_user).where(todo_list_id: @todo_list).order(created_at: :asc)

    filtering_params.each do |key, value|
      @todos = @todos.public_send(key, value) if value.present?
    end
  end
end
