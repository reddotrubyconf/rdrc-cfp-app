# frozen_string_literal: true

class SessionsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :missing_credentials

  # GET /auth/github/callback
  def create
    sign_in(auth_user)

    redirect_to my_papers_path
  end

  # DELETE /auth/github
  def destroy
    sign_out

    redirect_to root_path
  end

  private

  def auth_user
    User.find_by(email: request.env["omniauth.auth"].dig(:info, :email)) ||
      User.create_from_auth!(request.env["omniauth.auth"])
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
  end

  def missing_credentials
    message = "Whoops! We need to grab your name and e-mail from GitHub to authenticate you. " \
              "Please check that they are available from your profile and try agian."

    redirect_to root_path, flash: { error: message }
  end
end
