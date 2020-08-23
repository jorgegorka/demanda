# frozen_string_literal: true

class AdminController < AuthenticatedController
  before_action :user_is_admin

  class UnauthorizedUserError < StandardError
  end

  rescue_from AdminController::UnauthorizedUserError do
    render nothing: true, status: :unauthorized
  end

  private

  def user_is_admin
    raise UnauthorizedUserError unless current_user.isManager?
  end
end
