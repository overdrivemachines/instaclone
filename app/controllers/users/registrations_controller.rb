# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # def new
  #   super
  # end

  # def create
  #   super
  # end

  # def edit
  #   super
  # end

  # @route GET /users/edit_details (users_edit_details)
  def edit_details
    @user = current_user
  end

  # @route PATCH /users/save_details (users_save_details)
  def save_details
    redirect_to root_url unless user_signed_in?
    @user = current_user
    if @user.update(user_details_params)
      redirect_to users_edit_details_path, notice: "Your account details have been saved."
    else
      # redirect_to users_edit_details_path, alert: "There has been an error."
      render :edit_details, status: :unprocessable_entity
    end
  end

  # TODO
  def destroy_avatar
    current_user.avatar.purge
    redirect_to users_edit_details_path, status: :see_other, notice: "Removed avatar image"
  end

  # TODO
  def destroy_avatar_background
    current_user.avatar_background.purge
    redirect_to users_edit_details_path, status: :see_other, notice: "Removed avatar background image"
  end

  # PUT /resource
  # def update
  #   super
  # end

  # def destroy
  #   super
  # end

  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :full_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :full_name])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(_resource)
    # super(resource)
    # Go to: /home/message
    home_message_path
  end

  def user_details_params
    params.require(:user).permit(:full_name, :username, :avatar, :bio, :avatar_background)
  end
end
