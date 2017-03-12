# frozen_string_literal: true

require "rails_helper"

RSpec.describe PapersForReviewFinder, type: :finder do
  let(:reviewer) { FactoryGirl.create(:user, :reviewer) }

  subject(:finder) { described_class.new(reviewer) }

  describe "#reviewed" do
    context "with a mix of reviewed and unreviewed papers" do
      let(:reviewed_paper)   { FactoryGirl.create(:paper, :scrubbed) }
      let(:unreviewed_paper) { FactoryGirl.create(:paper, :scrubbed) }

      before { FactoryGirl.create(:review, paper: reviewed_paper, user: reviewer) }

      it { expect(finder.reviewed).to contain_exactly(reviewed_paper) }
    end

    context "when there are reviews made by others" do
      let(:other_reviewer) { FactoryGirl.create(:user,  :reviewer) }
      let(:reviewed_paper) { FactoryGirl.create(:paper, :scrubbed) }

      before { FactoryGirl.create(:review, paper: reviewed_paper, user: other_reviewer) }

      it { expect(finder.reviewed).to be_empty }
    end
  end

  describe "#unreviewed" do
    context "with a mix of reviewed and unreviewed papers" do
      let(:reviewed_paper)   { FactoryGirl.create(:paper, :scrubbed) }
      let(:unreviewed_paper) { FactoryGirl.create(:paper, :scrubbed) }

      before { FactoryGirl.create(:review, paper: reviewed_paper, user: reviewer) }

      it { expect(finder.unreviewed).to contain_exactly(unreviewed_paper) }
    end

    context "when there are unscrubbed papers" do
      let(:reviewed_paper) { FactoryGirl.create(:paper, :submitted) }

      it { expect(finder.reviewed).to be_empty }
    end
  end
end
