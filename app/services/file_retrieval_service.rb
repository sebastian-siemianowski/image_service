# frozen_string_literal: true

class FileRetrievalService
  def retrieve(file_reference:, extension: nil)
    s3 = Aws::S3::Resource.new
    bucket_name = 'rudph2xxximageservicexxxtest'

    bucket = s3.bucket(bucket_name)
    original_prefix = "images/#{file_reference}/original/"
    original_file = bucket.objects(prefix: original_prefix).collect(&:key).first
    puts '1'
    puts original_file
    puts original_prefix
    return bucket.object(original_file).get.body if extension.nil?

    extension_file = bucket.objects(prefix: "images/#{file_reference}/.#{extension}/").collect(&:key).first
    puts extension_file
    puts '2'
    return bucket.object(extension_file).get.body if extension_file

    transformation_service = ImageFormatTransformationService.new
    transformation_service.format = extension
    transformation_service.image_blob = bucket.object(original_file).get.body
    new_image = transformation_service.convert
    puts '3'
    file_name = original_file.gsub(original_prefix, '')
    puts file_name
    file_name_without_extension = file_name.gsub(File.extname(original_file), '')
    file_upload_service = FileUploadService.new
    file_upload_service.uuid = file_reference
    new_file_name = "#{file_name_without_extension}.#{extension}"
    puts new_file_name
    file_upload_service.upload(file_content: new_image, file_name: new_file_name)

    extension_file = bucket.objects(prefix: "images/#{file_reference}/.#{extension}/").collect(&:key).first
    puts extension_file
    bucket.object(extension_file).get.body
  end
end
