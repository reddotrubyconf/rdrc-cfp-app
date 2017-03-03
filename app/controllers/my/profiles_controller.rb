# frozen_string_literal: true

class My::ProfilesController < ApplicationController
  layout "cfp"

  before_action :authenticate!
  before_action :authorize_speaker!

  # GET /profile
  def show
    @user = current_user
  end

  # GET /profile/edit
  def edit
    @user = current_user
  end

  # PATCh /profile
  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to my_profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence.capitalize
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:bio)
  end
end
