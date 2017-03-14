# frozen_string_literal: true

require "rails_helper"

RSpec.describe My::PapersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    FactoryGirl.create(:conference, cfp_status)

    sign_in(user)
  end

  describe "#index" do
    let(:cfp_status) { :open_for_cfp }

    before { get :index }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#new" do
    before { get :new }

    context "when CFP is open" do
      let(:cfp_status) { :open_for_cfp }

      it { expect(response).to have_http_status(:success) }
    end

    context "when CFP is closed" do
      let(:cfp_status) { :closed_for_cfp }

      it { is_expected.to set_flash[:notice] }
      it { expect(response).to have_http_status(:redirect) }
    end
  end

  describe "#create" do
    context "when CFP is open" do
      let(:cfp_status) { :open_for_cfp }

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

    context "when CFP is closed" do
      let(:cfp_status) { :closed_for_cfp }

      before { post :create, params: { paper: FactoryGirl.attributes_for(:paper) } }

      it { is_expected.to set_flash[:notice] }
      it { expect(response).to have_http_status(:redirect) }
    end
  end

  describe "#show" do
    let(:cfp_status) { :open_for_cfp }
    let(:paper) { FactoryGirl.create(:paper, user: user) }

    before { get :show, params: { id: paper.id } }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#edit" do
    let(:paper) { FactoryGirl.create(:paper, user: user) }

    before { get :edit, params: { id: paper.id } }

    context "when CFP is open" do
      let(:cfp_status) { :open_for_cfp }

      it { expect(response).to have_http_status(:success) }
    end

    context "when CFP is closed" do
      let(:cfp_status) { :closed_for_cfp }

      it { is_expected.to set_flash[:notice] }
      it { expect(response).to have_http_status(:redirect) }
    end
  end

  describe "#update" do
    let(:paper) { FactoryGirl.create(:paper, user: user) }

    context "when CFP is open" do
      let(:cfp_status) { :open_for_cfp }

      context "with valid params" do
        before { patch :update, params: { id: paper.id, paper: FactoryGirl.attributes_for(:paper) } }

        it { expect(response).to have_http_status(:found) }
      end

      context "with invalid params" do
        before { patch :update, params: { id: paper.id, paper: FactoryGirl.attributes_for(:paper, :invalid) } }

        it { is_expected.to set_flash[:error] }
        it { expect(response).to have_http_status(:success) }
      end
    end

    context "when CFP is closed" do
      let(:cfp_status) { :closed_for_cfp }

      before { patch :update, params: { id: paper.id, paper: FactoryGirl.attributes_for(:paper) } }

      it { is_expected.to set_flash[:notice] }
      it { expect(response).to have_http_status(:redirect) }
    end
  end
end
