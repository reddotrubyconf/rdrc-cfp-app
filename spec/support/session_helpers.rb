# frozen_string_literal: true

module SessionHelpers
  def sign_in(user)
    subject.session[:user_id] = user.id
  end

  def sign_out
    subject.session.delete(:user_id)
  end
end
