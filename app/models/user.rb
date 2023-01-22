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
      Membership.create!(team: default_team, user: user)
    end
    user
  end

  def gravatar_url
    require 'digest/md5'
    email_md5 = Digest::MD5.hexdigest(email)
    "https://gravatar.com/avatar/#{email_md5}"
  end

end
