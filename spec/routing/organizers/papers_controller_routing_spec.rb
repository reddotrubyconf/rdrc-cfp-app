# frozen_string_literal: true

require "rails_helper"

RSpec.describe Organizers::PapersController, type: :routing do
  it { expect(get   "/organizers/papers").to   route_to("organizers/papers#index") }
  it { expect(get   "/organizers/papers/1").to route_to("organizers/papers#show", id: "1") }
end
