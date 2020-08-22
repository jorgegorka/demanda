# frozen_string_literal: true

class AttachmentsController < AuthenticatedController
  def create
    Attachments::Persistence.new(current_account).create(valid_params)
  end

  def delete; end

  private

  def valid_params
    params.permit(:parent_id, :parent_type, :files, :title, :language_id)
  end
end
