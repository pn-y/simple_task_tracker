module ApplicationHelper
  def generate_transitions_collection(task)
    [[nil, t("tasks.status.#{task.status}")]] +
      task.status_transitions.map { |t| [t.event, t("task.status.#{t.to}")] }
  end

  def options_for_users_select
    @user_emails ||= User.pluck(:email)
    options_for_select(@user_emails.map { |x| [x, x] }, params[:creator])
  end

  def options_for_status_select
    statuses = Task.state_machines[:status].states.map(&:value)
    options_for_select(statuses.map { |s| [t("task.status.#{s}"), s] }, params[:status])
  end
end
