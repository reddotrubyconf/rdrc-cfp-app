# frozen_string_literal: true

require "rails_helper"

RSpec.describe Paper, type: :model do
  subject(:paper) { FactoryGirl.build(:paper) }

  it { is_expected.to belong_to(:user).inverse_of(:papers) }

  it { is_expected.to have_many(:reviews).inverse_of(:paper) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:abstract) }
  it { is_expected.to validate_presence_of(:outline) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:speaker_slot) }

  it { is_expected.to define_enum_for(:status).with([:draft, :submitted, :scrubbed, :accepted, :rejected, :withdrawn]) }
  it { is_expected.to define_enum_for(:speaker_slot).with([:lightning, :regular]) }

  describe "#editable?" do
    subject(:paper) { FactoryGirl.build(:paper, status: status) }

    context "when the paper is a draft" do
      let(:status) { :draft }

      it { expect(paper).to be_editable }
    end

    context "when the paper is submitted" do
      let(:status) { :submitted }

      it { expect(paper).to be_editable }
    end

    context "when the paper is accepted" do
      let(:status) { :accepted }

      it { expect(paper).not_to be_editable }
    end

    context "when the paper is rejected" do
      let(:status) { :rejected }

      it { expect(paper).not_to be_editable }
    end

    context "when the paper is withdrawn" do
      let(:status) { :withdrawn }

      it { expect(paper).not_to be_editable }
    end
  end

  describe "#review_by" do
    context "when a review by the user exists" do
      let(:paper)    { FactoryGirl.create(:paper, :scrubbed, :with_review) }
      let(:review)   { paper.reviews.last }
      let(:reviewer) { review.user }

      it { expect(paper.review_by(reviewer)).to eq(review) }
    end

    context "when no review by the user exists" do
      let(:paper)    { FactoryGirl.create(:paper, :scrubbed) }
      let(:reviewer) { FactoryGirl.create(:user, :reviewer) }

      it { expect(paper.review_by(reviewer)).to be_instance_of(NoReview) }
    end

    context "when a review by another user exists" do
      let(:paper)          { FactoryGirl.create(:paper, :scrubbed, :with_review) }
      let(:review)         { paper.reviews.last }
      let(:other_reviewer) { review.user }
      let(:reviewer)       { FactoryGirl.create(:user, :reviewer) }

      it { expect(paper.review_by(reviewer)).to be_instance_of(NoReview) }
    end
  end
end
