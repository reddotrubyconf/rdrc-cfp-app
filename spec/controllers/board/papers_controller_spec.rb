# frozen_string_literal: true

require "rails_helper"

RSpec.describe Board::PapersController, type: :controller do
  let(:reviewer) { FactoryGirl.create(:user, :reviewer) }
  let(:speaker) { FactoryGirl.create(:user) }

  before do
    sign_in(reviewer)
  end

  describe "#index" do
    before { get :index }

    it { expect(response).to have_http_status(:success) }
  end
end
