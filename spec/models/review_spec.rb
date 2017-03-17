# frozen_string_literal: true

require "rails_helper"

RSpec.describe Review, type: :model do
  subject(:review) { FactoryGirl.build(:review) }

  it { is_expected.to belong_to(:user).inverse_of(:reviews) }
  it { is_expected.to belong_to(:paper).inverse_of(:reviews) }

  it { is_expected.to validate_numericality_of(:score).only_integer.is_greater_than_or_equal_to(1).is_less_than_or_equal_to(5) }
end
