# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end

  private

  def account_from_request
    Account.find_by!(domain: request.headers['HTTP_ORIGIN'])
  end
end
