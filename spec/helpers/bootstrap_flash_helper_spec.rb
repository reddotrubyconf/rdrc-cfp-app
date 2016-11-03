# frozen_string_literal: true

require "rails_helper"

RSpec.describe BootstrapFlashHelper, type: :helper do
  describe "#flash_messages" do
    let(:flash_hash) { ActionDispatch::Flash::FlashHash.new }

    before do
      flash.each do |type, message|
        flash_hash[:type] = message
      end
      session[:flash] = flash_hash.to_session_value
    end

    context "when `flash` is empty" do
      let(:flash) do
        {}
      end

      let(:expected_markup) { nil }

      it { expect(flash_messages).to eq(expected_markup) }
    end

    context "when `flash` contains a success message" do
      let(:flash) do
        { success: "foo" }
      end

      let(:expected_markup) do
        <<-HTML
          <div class="container">
            <div class="alert alert-success">
              <button class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove"></span>
              </button>
              foo
            </div>
          </div>
        HTML
        .each_line.map(&:strip).join
      end

      it { expect(flash_messages).to eq(expected_markup) }
    end

    context "when `flash` contains an error message" do
      let(:flash) do
        { error: "foo" }
      end

      let(:expected_markup) do
        <<-HTML
          <div class="container">
            <div class="alert alert-danger">
              <button class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove"></span>
              </button>
              foo
            </div>
          </div>
        HTML
        .each_line.map(&:strip).join
      end

      it { expect(flash_messages).to eq(expected_markup) }
    end

    context "when `flash` contains an alert message" do
      let(:flash) do
        { alert: "foo" }
      end

      let(:expected_markup) do
        <<-HTML
          <div class="container">
            <div class="alert alert-warning">
              <button class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove"></span>
              </button>
              foo
            </div>
          </div>
        HTML
        .each_line.map(&:strip).join
      end

      it { expect(flash_messages).to eq(expected_markup) }
    end

    context "when `flash` contains a notice message" do
      let(:flash) do
        { notice: "foo" }
      end

      let(:expected_markup) do
        <<-HTML
          <div class="container">
            <div class="alert alert-info">
              <button class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove"></span>
              </button>
              foo
            </div>
          </div>
        HTML
        .each_line.map(&:strip).join
      end

      it { expect(flash_messages).to eq(expected_markup) }
    end

    context "when `flash` contains several different messages" do
      let(:flash) do
        {
          notice: "foo",
          alert: "bar"
        }
      end

      let(:expected_markup) do
        <<-HTML
          <div class="container">
            <div class="alert alert-info">
              <button class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove"></span>
              </button>
              foo
            </div>
            <div class="alert alert-warning">
              <button class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove"></span>
              </button>
              bar
            </div>
          </div>
        HTML
        .each_line.map(&:strip).join
      end

      it { expect(flash_messages).to eq(expected_markup) }
    end
  end
end
