# frozen_string_literal: true

class ImagesController < ApplicationController
  def show
    FileRetrievalService.new.retrieve(file_reference: params[:id], extension: params[:extension])
  end

  def create
    FileUploadService.new.upload(file_content: params[:image_content], file_name: params[:image_name])
  end

  private

  def image_creation_params
    params.permit([:image_content, :mage_name])
  end

  def image_retrieval_params
    params.permit([:id, :extension])
  end
end
