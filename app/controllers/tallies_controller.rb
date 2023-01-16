class TalliesController < ApplicationController
  before_action :set_tally, only: %i[ show edit update destroy increment ]

  def show
  end
  def edit
  end
  # DELETE /tallies/1 or /tallies/1.json
  def destroy
    parent_cat = @tally.category_id
    @tally.destroy

    respond_to do |format|
      format.html { redirect_to edit_category_path(parent_cat), notice: "Tally was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @tally.update(tally_params)
        format.html { redirect_to edit_category_path(@tally.category), notice: "Note was successfully added." }
        format.json { render :show, status: :ok, location: categories_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tally.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_tally
    @tally = Tally.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tally_params
    params.require(:tally).permit(:id,:notes)
  end
end
