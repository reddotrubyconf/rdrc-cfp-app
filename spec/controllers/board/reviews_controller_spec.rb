# frozen_string_literal: true

require "rails_helper"

RSpec.describe Board::ReviewsController, type: :controller do
  let(:reviewer) { FactoryGirl.create(:user, :reviewer) }
  let(:speaker)  { FactoryGirl.create(:user) }
  let(:paper)    { FactoryGirl.create(:paper, user: speaker) }

  before do
    sign_in(reviewer)
  end

  describe "#snew" do
    let(:paper) { FactoryGirl.create(:paper, :scrubbed, user: speaker) }

    before { get :new, params: { paper_id: paper.id } }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#create" do
    before { post :create, params: { paper_id: paper.id, review: params } }

    context "when no review exists" do
      context "with valid params" do
        let(:params) { FactoryGirl.attributes_for(:review) }

        it { is_expected.not_to set_flash[:error] }
        it { expect(response).to have_http_status(:redirect) }
      end

      context "with invalid params" do
        let(:params) { FactoryGirl.attributes_for(:review, :invalid) }

        it { is_expected.to set_flash[:error] }
        it { expect(response).to have_http_status(:success) }
      end
    end

    context "when a review already exists" do
      before { FactoryGirl.create(:review, paper: paper, user: reviewer) }

      context "with valid params" do
        let(:params) { FactoryGirl.attributes_for(:review) }

        it { is_expected.not_to set_flash[:error] }
        it { expect(response).to have_http_status(:redirect) }
      end

      context "with invalid params" do
        let(:params) { FactoryGirl.attributes_for(:review, :invalid) }

        it { is_expected.to set_flash[:error] }
        it { expect(response).to have_http_status(:success) }
      end
    end
  end
end
