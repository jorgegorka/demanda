# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = { current_user: current_user, current_account: current_account }
    result = DemandaSchema.execute(query, variables: variables, context: context, operation_name: operation_name)

    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def current_user
    @current_user ||= Jwt::UserAuthenticator.validate(request.headers)
  rescue StandardError
    nil
  end

  def current_account
    current_user ? current_user.account : Account.find_by(domain: requested_domain)
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: :internal_server_error
  end

  def requested_domain
    # protocol = request.headers['HTTPS'] == 'off' ? 'http://' : 'https://'

    # "#{protocol}#{request.headers['SERVER_NAME']}"
    "http://#{request.headers['SERVER_NAME']}"
  end
end
