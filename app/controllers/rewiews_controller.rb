class ReviewsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_playlist

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.playlist = @playlist

    respond_to do |format|
      if @review.save
        cookies[:saved_review] = true
        format.html { redirect_to [@playlist.user, @playlist], notice: 'Review was successfully created.' }
        format.js
      else
        format.html { redirect_to [@playlist.user, @playlist], notice: 'Errors' }
        format.js
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_playlist
      @playlist = Playlist.find(params[:playlist_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
