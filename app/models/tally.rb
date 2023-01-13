class Tally < ApplicationRecord
  belongs_to :category

  def last_updated_local
    created_at + Time.zone_offset('PST')
  end

  def last_updated_formatted
    last_updated_local.strftime("%B %d %Y at %I:%M %P")
  end
end
