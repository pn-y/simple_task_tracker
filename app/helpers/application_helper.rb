module ApplicationHelper
  def generate_transitions_collection(task)
    [[nil, t("tasks.status.#{task.status}")]] +
      task.status_transitions.map { |t| [t.event, t("task.status.#{t.to}")] }
  end
end
