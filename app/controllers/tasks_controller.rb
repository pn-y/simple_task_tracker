class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:edit, :update]

  def index
    @tasks = TaskFilterService.new(params, Task.includes(:owner, :creator)).resolve
  end

  def new
    @task = current_user.created_tasks.new
  end

  def create
    @task = current_user.created_tasks.new(task_params)

    if @task.save
      redirect_to tasks_url, notice: t('tasks.flash.create')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_url, notice: t('tasks.flash.update')
    else
      render :edit
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :status_event, :owner_id)
  end
end
