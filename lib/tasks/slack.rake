# frozen_string_literal: true

require "httparty"
require "json"

TODAY = Date.current.freeze
WEBHOOK = ENV["SLACK_WEBHOOK_URL"].freeze
HEADERS = { "Content-Type" => "application/json" }.freeze

namespace :slack do
  desc "Send an update about the CFP status"
  task send_cfp_status_update: :environment do
    MESSAGE = "We had %d new CFP submissions in the last week, for a total of %d.".freeze

    # Heroku Scheduler can only run on a daily interval, but we want a weekly
    # report, so do nothing for the other days.
    next unless TODAY.tuesday?

    new_submission_period = (TODAY - 1.week).upto(TODAY)

    new_submissions = Paper.submitted.where(updated_at: new_submission_period.to_a).count
    all_submissions = Paper.submitted.count

    message = format(MESSAGE, new_submissions, all_submissions)

    HTTParty.post(WEBHOOK, body: { text: message }.to_json, headers: HEADERS)
  end
end
