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
end
