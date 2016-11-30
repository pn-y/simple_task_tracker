class TaskFilterService
  attr_reader :params, :initial_relation

  def initialize(params, initial_relation)
    @params = params
    @initial_relation = initial_relation
  end

  def resolve
    initial_relation.
      with_status(params[:status]).
      with_creator(params[:creator]).
      with_owner(params[:owner]).
      with_title(params[:title]).
      page(params[:page])
  end
end
