# frozen_string_literal: true

class My::ProfilesController < ApplicationController
  before_action :authenticate!

  # GET /profile
  def show
    @user = current_user
  end
end
