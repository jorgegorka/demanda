# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  rescue_from ActionController::ParameterMissing do
    render nothing: true, status: :bad_request
  end

  rescue_from JWT::DecodeError do
    render nothing: true, status: :unauthorized
  end

  private

  def current_user
    @current_user ||= Jwt::UserAuthenticator.validate(request.headers)
  end

  def current_account
    current_user ? current_user.account : account_from_request
  end
end
