class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def self.find_by_permalink(params)
    params => { year:, ordinal_day:, time: }
    date = Date.ordinal(year.to_i, ordinal_day.to_i)

    # re-insert the colons into the time
    time.match?(/^\d{6}$/) ? time.insert(2, ":").insert(5, ":") : nil

    published_at = Time.zone.parse("#{date}T#{time}")

    find_by(published_at:)
  end
end