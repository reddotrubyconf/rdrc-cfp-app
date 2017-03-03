# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cleaners::PapersController, type: :controller do
  let(:cleaner) { FactoryGirl.create(:user, :cleaner) }
  let(:speaker) { FactoryGirl.create(:user) }

  before do
    sign_in(cleaner)
  end

  describe "#index" do
    before { get :index }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#edit" do
    let(:paper) { FactoryGirl.create(:paper, user: speaker) }

    before { get :edit, params: { id: paper.id } }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#update" do
    let(:paper) { FactoryGirl.create(:paper, user: speaker) }

    context "with valid params" do
      before { patch :update, params: { id: paper.id, paper: { scrubbed_outline: "Foo" } } }

      it { expect(response).to have_http_status(:found) }
    end

    context "with invalid params" do
      before { patch :update, params: { id: paper.id, paper: { scrubbed_outline: "" } } }

      it { is_expected.to set_flash[:error] }
      it { expect(response).to have_http_status(:success) }
    end
  end
end
