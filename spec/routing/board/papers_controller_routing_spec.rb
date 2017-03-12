# frozen_string_literal: true

require "rails_helper"

RSpec.describe Board::PapersController, type: :routing do
  it { expect(get "/board/papers").to   route_to("board/papers#index") }
end
