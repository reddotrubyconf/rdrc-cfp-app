# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def authenticate!
    redirect_to sign_in_github_path unless current_user
  end

  def authorize_cleaner!
    redirect_to root_path unless current_user.cleaner?
  end

  def authorize_speaker!
    redirect_to root_path unless current_user.speaker?
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end
