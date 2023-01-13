Passwordless.default_from_address = ENV['MAIL_FROM']

Passwordless.expires_at = lambda { 1.week.from_now } # How long until a passwordless session expires.
Passwordless.timeout_at = lambda { 15.minutes.from_now } # How long until a magic link expires.

# Passwordless.failure_redirect_path = '/pages/failure' # When a a login is failed for any reason.
# # Passwordless.sigçn_out_redirect_path = '/pages/signed_out' # When a user logs out.