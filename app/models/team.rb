class Team < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships
  has_many :categories, :dependent => :destroy

  def owner
    memberships.find_by(role: 'owner').user
  end
end
