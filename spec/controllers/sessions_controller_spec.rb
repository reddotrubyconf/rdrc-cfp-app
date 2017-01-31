# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "#create" do
    context "with all credentials present" do
      before do
        allow(subject).to receive(:auth_user) { FactoryGirl.build(:user) }
      end

      before { post :create }

      it { is_expected.to set_session[:user_id] }
      it { expect(response).to have_http_status(:found) }
    end

    context "with missing credentials" do
      before do
        allow(subject).to receive(:auth_user).and_raise(ActiveRecord::RecordInvalid)
      end

      before { post :create }

      it { is_expected.to set_flash[:error] }
      it { is_expected.to_not set_session[:user_id] }
      it { expect(response).to have_http_status(:found) }
    end
  end

  describe "#destroy" do
    before do
      sign_in(FactoryGirl.build_stubbed(:user))
    end

    before { delete :destroy }

    it { is_expected.to_not set_session[:user_id] }
    it { expect(response).to have_http_status(:found) }
  end
end
