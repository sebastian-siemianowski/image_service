# frozen_string_literal: true

require 'rails_helper'

describe FileUploadService do
  subject { described_class.new }

  let(:file_content) { File.read("#{Rails.root}/spec/services/image_files_for_testing/hamster.jpg") }
  let(:file_content_base64) { Base64.strict_encode64(file_content) }
  let(:file_name) { 'hamster.jpg' }
  let(:format) { 'jpg' }

  it 'returns the unique reference id' do
    expect(subject.upload(file_content: file_content_base64,
                          file_name: file_name,
                          format: format)).to be_a String
  end
end
