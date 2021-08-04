class AdminController < AuthenticatedController
  before_action :user_is_manager

  class UnauthorizedUserError < StandardError
  end

  rescue_from AdminController::UnauthorizedUserError do
    render nothing: true, status: :unauthorized
  end

  private

  def user_is_manager
    raise UnauthorizedUserError unless current_user.is_manager?
  end
end
