module ApplicationHelper
  def generate_transitions_collection(task)
    [[nil, task.human_status_name]] +
      task.status_transitions.map { |t| [t.event, t.human_to_name] }
  end

  def options_for_users_select(selected)
    @user_emails ||= User.pluck(:email)
    options_for_select(@user_emails.map { |x| [x, x] }, selected)
  end

  def options_for_status_select(selected)
    options_for_select(
      Task.state_machines[:status].states.map { |s| [s.human_name, s.value] },
      selected
    )
  end
end
