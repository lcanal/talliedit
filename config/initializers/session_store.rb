# frozen_string_literal: true
# Fixes mobile issue constantly logging you out
# https://github.com/mikker/passwordless/issues/102

Rails.application.config.session_store :cookie_store, expire_after: 1.week