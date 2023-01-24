class UserMailer < ApplicationMailer
  def invite_email
    @user = params[:user]
    @inviter = params[:inviter]
    @team = params[:team]
    mail(to: @user.email, subject: 'You have been invited to join a team')
  end
end
