class RewiewsController < ApplicationController
  before_action :set_rewiew, only: [:show, :edit, :update, :destroy]

  # GET /rewiews
  # GET /rewiews.json
  def index
    @rewiews = Rewiew.all
  end

  # GET /rewiews/1
  # GET /rewiews/1.json
  def show
  end

  # GET /rewiews/new
  def new
    @rewiew = Rewiew.new
  end

  # GET /rewiews/1/edit
  def edit
  end

  # POST /rewiews
  # POST /rewiews.json
  def create
    @rewiew = Rewiew.new(rewiew_params)

    respond_to do |format|
      if @rewiew.save
        format.html { redirect_to @rewiew, notice: 'Rewiew was successfully created.' }
        format.json { render :show, status: :created, location: @rewiew }
      else
        format.html { render :new }
        format.json { render json: @rewiew.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rewiews/1
  # PATCH/PUT /rewiews/1.json
  def update
    respond_to do |format|
      if @rewiew.update(rewiew_params)
        format.html { redirect_to @rewiew, notice: 'Rewiew was successfully updated.' }
        format.json { render :show, status: :ok, location: @rewiew }
      else
        format.html { render :edit }
        format.json { render json: @rewiew.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rewiews/1
  # DELETE /rewiews/1.json
  def destroy
    @rewiew.destroy
    respond_to do |format|
      format.html { redirect_to rewiews_url, notice: 'Rewiew was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rewiew
      @rewiew = Rewiew.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rewiew_params
      params.require(:rewiew).permit(:rating, :comment, :user_id, :playlist_id)
    end
end
