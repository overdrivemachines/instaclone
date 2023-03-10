# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # def new
  #   super
  # end

  # def create
  #   super
  # end

  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    # super(resource_name)
    # Go to: /home/message
    home_message_path
  end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
