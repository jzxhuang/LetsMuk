class TimeBlocksController < ApplicationController

  before_action :set_time_block, only: [:show, :update, :destroy]

  # GET /time_blocks
  def index
    @time_blocks = TimeBlock.search(search_params).all

    render json: @time_blocks
  end

  # GET /time_blocks/1
  def show
    render json: @time_block
  end

  # POST /time_blocks
  def create
    @time_block = TimeBlock.new(time_block_params)

    if @time_block.save
      render json: @time_block, status: :created, location: @time_block
    else
      render json: @time_block.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /time_blocks/1
  def update
    if @time_block.update(time_block_params)
      render json: @time_block
    else
      render json: @time_block.errors, status: :unprocessable_entity
    end
  end

  # DELETE /time_blocks/1
  def destroy
    @time_block.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_time_block
    @time_block = TimeBlock.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def time_block_params
    params.require(:time_block).permit(%i[start end title status user_id])
  end

  def search_params
    params.permit(:after, :before, :user_id)
  end
end
