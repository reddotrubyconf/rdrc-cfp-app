# frozen_string_literal: true

require "rails_helper"

RSpec.describe Conference, type: :model do
  subject(:paper) { FactoryGirl.build(:conference) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:cfp_closes_at) }

  describe "#cfp_closed?" do
    context "when CFP submission date is in the past" do
      subject(:paper) { FactoryGirl.build(:conference, :closed_for_cfp) }

      it { expect(paper.cfp_closed?).to be_truthy }
    end

    context "when CFP submission date is in the future" do
      subject(:paper) { FactoryGirl.build(:conference, :open_for_cfp) }

      it { expect(paper.cfp_closed?).to be_falsey }
    end
  end

  describe "#cfp_open?" do
    context "when CFP submission date is in the past" do
      subject(:paper) { FactoryGirl.build(:conference, :closed_for_cfp) }

      it { expect(paper.cfp_open?).to be_falsey }
    end

    context "when CFP submission date is in the future" do
      subject(:paper) { FactoryGirl.build(:conference, :open_for_cfp) }

      it { expect(paper.cfp_open?).to be_truthy }
    end
  end
end
