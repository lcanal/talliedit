class User < ApplicationRecord
  has_many :memberships
  has_many :teams, through: :memberships

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  passwordless_with :email

  # Add this so that users can be created!
  # don't add this if you want your app to be invite-only
  def self.fetch_resource_for_passwordless(email)
    user = find_or_create_by(email:)
    if user.teams.count == 0
      default_team = Team.create!(name: "My Team")
      Membership.create!(team: default_team, user: user, role: 'owner')
    end
    if user.memberships.where(role: 'pending').count > 0
      user.memberships.where(role: 'pending').each do |membership|
        membership.update(role: 'member')
      end
    end
    user
  end

  def gravatar_url
    require 'digest/md5'
    email_md5 = Digest::MD5.hexdigest(email)
    "https://gravatar.com/avatar/#{email_md5}"
  end

  def pending_teams
    memberships.where(role: 'pending').map(&:team)
  end

  def pending_membership(team)
    memberships.find_by(team: team, role: 'pending')
  end

  def active_teams
    memberships.where(role: ['owner','member']).map(&:team)
  end

  def your_teams
    memberships.where(role: 'owner').map(&:team)
  end

  def member_teams
    memberships.where(role: 'member').map(&:team)
  end

  def determine_membership(team)
    membership = memberships.where(team: team).first
    if membership.nil?
      "none"
    else
      membership.role
    end
  end
end
