# frozen_string_literal: true

class AttachmentsController < AdminController
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature do
    render nothing: true, status: :bad_request
  end

  def create
    Attachments::Persistence.new(current_account).create(valid_params)
  end

  def destroy
    Attachments::Persistence.new(current_account).destroy(attachment)
  end

  private

  def valid_params
    params.permit(:parent_id, :parent_type, :files, :title, :language_id)
  end

  def attachment
    attachment = Attachment.find_by!(uuid: params[:id])
    return nil if attachment.attachable.account != current_account

    attachment
  end
end
