# frozen_string_literal: true

require "rails_helper"

RSpec.describe Board::ReviewsController, type: :routing do
  it { expect(get  "/board/papers/1/reviews/new").to route_to("board/reviews#new", paper_id: "1") }
  it { expect(post "/board/papers/1/reviews").to route_to("board/reviews#create", paper_id: "1") }
end
