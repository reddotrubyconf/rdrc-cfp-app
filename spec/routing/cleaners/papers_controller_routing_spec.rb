# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cleaners::PapersController, type: :routing do
  it { expect(get   "/cleaners/papers").to        route_to("cleaners/papers#index") }
  it { expect(get   "/cleaners/papers/1/edit").to route_to("cleaners/papers#edit",   id: "1") }
  it { expect(patch "/cleaners/papers/1").to      route_to("cleaners/papers#update", id: "1") }
end
