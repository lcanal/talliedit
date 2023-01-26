class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy invite send_invite]

  # GET /teams or /teams.json
  def index
    @teams = current_user.teams
    @pending_memberships = current_user.pending_teams
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  def invite
  end
  def send_invite
    user = User.find_by_email(params[:email])
    if user.nil?
      user = User.fetch_resource_for_passwordless(params[:email])
      membership = Membership.new(team: @team, user: user, role: 'pending')
      membership.save
      user.save
    else
      membership = Membership.new(team: @team, user: user, role: 'pending')
      membership.save
    end
    respond_to do |format|
        UserMailer.with(user: user, team: @team, inviter: current_user).invite_email.deliver_now
        format.html { redirect_to teams_path, notice: "Invite was successfully sent." }
        format.json { render :show, status: :created, location: teams_path }
      # else
      #   format.html { render :new, status: :unprocessable_entity }
      #   format.json { render json: @team.errors, status: :unprocessable_entity }
      # end
    end
  end

  def accept_invite
    membership = Membership.find(params[:id])
    membership.role = 'member'
    membership.save
    redirect_to teams_path
  end
  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)
    @membership = Membership.new(user: current_user, team: @team, role: 'owner')
    respond_to do |format|
      if @team.save and @membership.save
        format.html { redirect_to teams_path, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name,:email)
    end
end
