# frozen_string_literal: true

require "rails_helper"

RSpec.describe PapersController, type: :routing do
  it { expect(get  "/papers/new").to route_to("papers#new") }
  it { expect(post "/papers").to     route_to("papers#create") }
  it { expect(get  "/papers/1").to   route_to("papers#show", id: "1") }
end
