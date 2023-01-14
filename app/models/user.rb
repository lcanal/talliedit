class User < ApplicationRecord
  has_many :categories, :dependent => :destroy

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  passwordless_with :email

  # add this so that users can be created!
  # don't add this if you want your app to be invite-only
  def self.fetch_resource_for_passwordless(email)
    find_or_create_by(email:)
  end

  def gravatar_url
    require 'digest/md5'
    email_md5 = Digest::MD5.hexdigest(email)
    "https://gravatar.com/avatar/#{email_md5}"
  end

end
