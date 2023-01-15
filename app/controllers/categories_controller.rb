class CategoriesController < ApplicationController
  before_action :require_user!
  before_action :set_category, only: %i[ show edit update destroy increment decrement ]

  # GET /categories or /categories.json
  def index
    @categories = Category.where(user_id: current_user.id)
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: categories_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: categories_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def increment
    tally = Tally.new(category_id: @category.id)

    respond_to do |format|
      if tally.save
        format.html { redirect_to categories_path, notice: "Incremented '#{@category.name}'" }
        format.json { render :show, status: :ok, location: categories_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def decrement
    last_tally = @category.tallies.last
    respond_to do |format|
      if !last_tally.nil? and last_tally.destroy
        format.html { redirect_to categories_path, notice: "Decremented tally from '#{@category.name}'" }
        format.json { render :show, status: :ok, location: categories_path }
      else
        format.html { redirect_to categories_path, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.where(id: params[:id], user_id: current_user.id).first
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
