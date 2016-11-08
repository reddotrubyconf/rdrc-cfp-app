# frozen_string_literal: true

require "rails_helper"

RSpec.describe My::PapersController, type: :routing do
  it { expect(get  "/my/papers").to     route_to("my/papers#index") }
  it { expect(get  "/my/papers/new").to route_to("my/papers#new") }
  it { expect(post "/my/papers").to     route_to("my/papers#create") }
  it { expect(get  "/my/papers/1").to   route_to("my/papers#show", id: "1") }
end
