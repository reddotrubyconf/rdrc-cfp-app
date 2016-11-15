# frozen_string_literal: true

require "rails_helper"

RSpec.describe Paper, type: :model do
  subject(:paper) { FactoryGirl.build(:paper) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:abstract) }
  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to define_enum_for(:status) }

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
end
