# frozen_string_literal: true

require "rails_helper"

RSpec.describe Organizers::PapersController, type: :controller do
  let(:organizer) { FactoryGirl.create(:user, :organizer) }
  let(:speaker) { FactoryGirl.create(:user) }

  before do
    sign_in(organizer)
  end

  describe "#index" do
    before { get :index }

    it { expect(response).to have_http_status(:success) }
  end

  describe "#show" do
    let(:paper) { FactoryGirl.create(:paper, user: speaker) }

    before { get :show, params: { id: paper.id } }

    it { expect(response).to have_http_status(:success) }
  end
end
