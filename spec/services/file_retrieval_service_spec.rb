# frozen_string_literal: true

require 'rails_helper'

describe FileRetrievalService do
  subject { described_class.new }
  let(:file_reference) do
    FileUploadService.new.upload(file_content: file_content_base64,
                                 file_name: file_name)
  end
  let(:file_content) { File.read("#{Rails.root}/spec/services/image_files_for_testing/hamster.jpg") }
  let(:file_content_base64) { Base64.strict_encode64(file_content) }
  let(:file_name) { 'hamster.jpg' }

  it 'returns original file if the file was uploaded and no extension was provided' do
    expect(subject.retrieve(file_reference).string).to eq file_content
  end

  it 'return extension file if the file was uploaded and present' do
    expect(subject.retrieve(file_reference).string).to eq file_content
  end

  it 'returns transformed file if the file was uploaded but the extension is not present' do
    
  end
end
