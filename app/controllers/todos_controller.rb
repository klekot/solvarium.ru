class TodosController < ApplicationController
  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render partial: 'todos/todo', locals: {todo: @todo} 
    else
      render json: @todo.errors.to_json
    end
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(checked: false)
      render partial: 'todos/todo', locals: {todo: @todo}
    else
      render json: @todo.errors.to_json
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    if @todo.update(checked: true)
      render partial: 'todos/todo', locals: {todo: @todo}
    else
      render json: @todo.errors.to_json
    end
  end

  private

    def todo_params
      params.require(:todo).permit(
        :name,
        :checked,
        :project_id,
        :user_id
      )
    end
end