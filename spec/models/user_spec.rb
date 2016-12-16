# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject(:model) { FactoryGirl.build(:user) }

  it { is_expected.to have_many(:papers).inverse_of(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:bio).on(:update) }

  describe ".create_from_auth" do
    context "with valid attributes" do
      let(:auth) do
        { info: { name: "Anakin Skywalker", email: "vader@thedarkside.net" } }
      end

      it { expect { described_class.create_from_auth!(auth) }.to change { described_class.count }.by(1) }
    end

    context "with invalid attributes" do
      let(:auth) do
        { info: { name: "", email: "" } }
      end

      it { expect { described_class.create_from_auth!(auth) }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
