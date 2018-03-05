# frozen_string_literal: true

require 'rails_helper'

describe ImageFormatTransformationService do
  subject { described_class.new }

  let(:whitelist) { %w[jpg jpeg png pdf bmp tif tiff] }
  let(:file_content_jpg) { File.read("#{Rails.root}/spec/services/image_files_for_testing/hamster.jpg") }
  let(:file_content_base64_jpg) { Base64.strict_encode64(file_content_jpg) }
  let(:file_content_bmp) { File.read("#{Rails.root}/spec/services/image_files_for_testing/hamster.bmp", encoding: 'ASCII-8BIT') }
  let(:file_content_png_string) { 'PNG' }
  let(:file_name) { 'hamster.jpg' }

  before :each do
    subject.image_blob = file_content_jpg
  end

  it 'allows transforming file to png' do
    subject.format = 'png'
    expect(subject.convert).to include(file_content_png_string)
  end

  it 'contains whitelisted formats' do
    expect(subject.whitelist).to eq whitelist
  end

  it 'allows transforming file to bmp' do
    subject.format = 'bmp'
    expect(subject.convert).to eq file_content_bmp
  end
end
