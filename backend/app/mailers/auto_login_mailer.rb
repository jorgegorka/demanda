# frozen_string_literal: true

class AutoLoginMailer < ApplicationMailer
  def magic_login_email
    @user = params[:user]
    Rails.logger.info Rails.application.credentials.config
    host = Rails.application.credentials.config[:domains][:web]
    @link = "http://#{host}/auto-login?code=#{@user.magic_login_token}"

    mail(to: @user.email, subject: 'Your login link')
  end
end
