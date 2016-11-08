# frozen_string_literal: true

require "rails_helper"

RSpec.describe Paper, type: :model do
  subject(:model) { FactoryGirl.build(:paper) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:abstract) }
  it { is_expected.to validate_presence_of(:status) }

  it { is_expected.to define_enum_for(:status) }
end
