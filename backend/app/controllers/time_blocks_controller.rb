class TimeBlocksController < ApplicationController
  before_action :set_time_block, only: [:show, :update, :destroy]
  require 'agora_dynamic_key'

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

  def get_token
    expiration_time_in_seconds = 100000
    opts = {
      app_id: ENV['AGORA_APP_ID'],
      app_certificate: ENV['AGORA_APP_CERTIFICATE'],
      channel_name: params[:channel_name],
      uid: params[:user_id],
      role: AgoraDynamicKey::RTCTokenBuilder::Role::PUBLISHER,
      privilege_expired_ts: Time.now.to_i + expiration_time_in_seconds
    }

    result = AgoraDynamicKey::RTCTokenBuilder.build_token_with_uid(opts)

    render json: result
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
