# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionsController, type: :routing do
  it { expect(get    "/auth/github/callback").to route_to("sessions#create") }
  it { expect(delete "/auth/github").to          route_to("sessions#destroy") }
end
