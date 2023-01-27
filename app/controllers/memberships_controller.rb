class MembershipsController < ApplicationController
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to teams_path
  end
end
