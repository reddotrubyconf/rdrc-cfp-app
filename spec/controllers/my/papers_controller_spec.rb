# frozen_string_literal: true

require "rails_helper"

RSpec.describe My::PapersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(user)
  end

  describe "#new" do
    before { get :new }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#create" do
    context "with valid params" do
      before { post :create, params: { paper: FactoryGirl.attributes_for(:paper) } }

      it { expect(response).to have_http_status(:found) }
    end

    context "with invalid params" do
      before { post :create, params: { paper: FactoryGirl.attributes_for(:paper, :invalid) } }

      it { is_expected.to set_flash[:error] }
      it { expect(response).to have_http_status(:success) }
    end
  end

  describe "#show" do
    let(:paper) { FactoryGirl.create(:paper) }

    before { get :show, params: { id: paper.id } }

    it { expect(response).to have_http_status(:success) }
  end
end
