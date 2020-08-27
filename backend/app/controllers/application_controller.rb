# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json

  private

  def account_from_request
    Account.find_by!(domain: request.headers['HTTP_ORIGIN'])
  end
end
