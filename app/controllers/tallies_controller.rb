class TalliesController < ApplicationController
  before_action :set_tally, only: %i[ show edit update destroy increment ]

  # DELETE /tallies/1 or /tallies/1.json
  def destroy
    parent_cat = @tally.category_id
    @tally.destroy

    respond_to do |format|
      format.html { redirect_to edit_category_path(parent_cat), notice: "Tally was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_tally
    @tally = Tally.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:tally).permit(:id)
  end
end
