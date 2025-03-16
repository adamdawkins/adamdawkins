class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def self.find_by_permalink(params)
    params => { year:, ordinal_day:, time: }
    date = Date.ordinal(year.to_i, ordinal_day.to_i)

    # re-insert the colons into the time
    formatted_time = if time.match?(/^\d{6}$/)
                       time_copy = time.dup
                       time_copy.insert(2, ":").insert(5, ":")
                     else
                       time
                     end

    published_at = Time.zone.parse("#{date}T#{formatted_time}")

    find_by(published_at:)
  end

  def to_param
    id.to_s
  end
end