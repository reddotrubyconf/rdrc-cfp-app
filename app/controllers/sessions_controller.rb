# frozen_string_literal: true

class SessionsController < ApplicationController
  # GET /auth/github/callback
  def create
    sign_in(auth_user)

    redirect_to root_path
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
end
