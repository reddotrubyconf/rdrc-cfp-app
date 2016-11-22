# frozen_string_literal: true

require "rails_helper"

RSpec.describe PagesController, type: :routing do
  it { expect(get "/").to route_to("pages#home") }
end
