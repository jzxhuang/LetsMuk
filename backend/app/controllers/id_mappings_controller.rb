class IdMappingsController < ApplicationController
  def google_uid
    @mapping = IdMapping.where(agora_id: params[:agora_uid]).first
    render json: @mapping.google_uid
  end

  def agora_uid
    @mapping = IdMapping.where(google_uid: params[:google_uid]).first
    render json: @mapping.agora_uid
  end

  def create
    @mapping = IdMapping.where(google_uid: params[:google_uid], agora_uid: params[:agora_uid]).first_or_create

    if @mapping
      render json: @mapping, status: :created
    else
      render json: @mapping.errors, status: :unprocessable_entity
    end
  end

  private

  def mapping_params
    params.permit(:google_uid, :agora_uid)
  end
end
