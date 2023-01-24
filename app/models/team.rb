class Team < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_many :categories, :dependent => :destroy

  def owner
    memberships.find_by(role: 'owner').user
  end

  def members
    memberships.where(role: 'member').map(&:user)
  end
  def last_updated_local
    updated_at + Time.zone_offset('PST')
  end

  def created_at_local
    created_at + Time.zone_offset('PST')
  end

  def last_created_formatted
    created_at_local.strftime("%B %d %Y at %I:%M %P")
  end
end
