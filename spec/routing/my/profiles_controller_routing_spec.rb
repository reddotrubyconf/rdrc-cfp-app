# frozen_string_literal: true

require "rails_helper"

RSpec.describe My::ProfilesController, type: :routing do
  it { expect(get   "/my/profile").to      route_to "my/profiles#show" }
  it { expect(get   "/my/profile/edit").to route_to "my/profiles#edit" }
  it { expect(patch "/my/profile").to      route_to "my/profiles#update" }
end
