# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  rescue_from ActionController::ParameterMissing do
    render nothing: true, status: :bad_request
  end

  rescue_from JWT::DecodeError do
    render nothing: true, status: :unauthorized
  end

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end

  private

  def current_user
    @current_user ||= Jwt::UserAuthenticator.validate(request.headers)
  end

  def current_account
    current_user ? current_user.account : Account.find_by!(domain: request.headers['HTTP_ORIGIN'])
  end
end
