class Category < ApplicationRecord
  has_many :tallies, :dependent => :destroy

  def last_updated_local
    updated_at + Time.zone_offset('PST')
  end

  def last_tally
    tally = tallies.last
    unless tally.nil?
      return "Last tally: #{tally.last_updated_formatted}"
    end
    "No tallies yet"
  end

  def team_name
    Team.find(team_id).name
  end
end
