class Category < ApplicationRecord
  has_many :tallies, :dependent => :destroy

  def last_updated_local
    updated_at + Time.zone_offset('PST')
  end
end
