class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team

  def last_updated_local
    updated_at + Time.zone_offset('PST')
  end

  def last_updated_formatted
    last_updated_local.strftime("%B %d %Y at %I:%M %P")
  end

  def last_created_local
    created_at + Time.zone_offset('PST')
  end

  def last_created_formatted
    last_created_local.strftime("%B %d %Y at %I:%M %P")
  end
end
