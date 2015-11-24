class TodoListsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:public_show]
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]

  def index
    @todo_lists = current_user.todo_lists.all
    authorize TodoList
    respond_with(@todo_lists)
  end

  def show
    respond_with(@todo_list)
  end

  def new
    @todo_list = TodoList.new
    @todo_list.user = current_user
    authorize @todo_list
    respond_with(@todo_list)
  end

  def edit
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_list.user = current_user
    authorize @todo_list
    @todo_list.save
    respond_with(@todo_list)
  end

  def update
    @todo_list.update(todo_list_params)
    respond_with(@todo_list)
  end

  def destroy
    @todo_list.destroy
    respond_with(@todo_list)
  end

  def public_show
    @todo_list = TodoList.where(slug: params[:id]).first!
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
    authorize @todo_list
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :slug)
  end
end
