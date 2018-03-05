# frozen_string_literal: true

class ImagesController < ApplicationController
  def show
    retrieved_object = FileRetrievalService.new.retrieve(file_reference: image_retrieval_params[:id],
                                                         extension: image_retrieval_params[:extension])
    render status: :ok, json: { retrieved_object: Base64.encode64(retrieved_object.string) }
  end

  def create
    reference = FileUploadService.new.upload(file_content: image_creation_params[:image_content],
                                             file_name: image_creation_params[:image_name])
    render status: :ok, json: { reference: reference }
  end

  private

  def image_creation_params
    params.permit(%i[image_content image_name]).to_h
  end

  def image_retrieval_params
    params.permit(%i[id extension]).to_h
  end
end
