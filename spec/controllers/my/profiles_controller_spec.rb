# frozen_string_literal: true

require "rails_helper"

RSpec.describe My::ProfilesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
  end

  describe "#show" do
    before { get :show }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#edit" do
    before { get :edit }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#update" do
    let(:user) { FactoryGirl.create(:user) }

    context "with valid params" do
      before { patch :update, params: { id: user.id, user: FactoryGirl.attributes_for(:user, bio: "Hello world!") } }

      it { expect(response).to have_http_status(:found) }
    end

    context "with invalid params" do
      before { patch :update, params: { id: user.id, user: FactoryGirl.attributes_for(:user, :invalid) } }

      it { is_expected.to set_flash[:error] }
      it { expect(response).to have_http_status(:success) }
    end
  end
end
