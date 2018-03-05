# frozen_string_literal: true

class FileRetrievalService
  def retrieve(file_reference:, extension: nil)
    s3 = Aws::S3::Resource.new
    bucket_name = 'rudph2xxximageservicexxxtest'

    bucket = s3.bucket(bucket_name)
    original_prefix = "images/#{file_reference}/original/"
    original_file = bucket.objects(prefix: original_prefix).collect(&:key).first
    raise ArgumentError, 'No Referenced File was found' unless original_file
    original_image_body = bucket.object(original_file).get.body
    return original_image_body if extension.nil?

    extension_file = bucket.objects(prefix: "images/#{file_reference}/.#{extension}/").collect(&:key).first
    return bucket.object(extension_file).get.body if extension_file

    new_image = transform_image(bucket, extension, original_file)

    upload_new_version_of_the_image(extension, file_reference, new_image, original_file, original_prefix)

    extension_file = bucket.objects(prefix: "images/#{file_reference}/.#{extension}/").collect(&:key).first
    bucket.object(extension_file).get.body
  end

  private

  def upload_new_version_of_the_image(extension, file_reference, new_image, original_file, original_prefix)
    file_name = original_file.gsub(original_prefix, '')
    file_name_without_extension = file_name.gsub(File.extname(original_file), '')
    new_file_name = "#{file_name_without_extension}.#{extension}"
    file_upload_service = FileUploadService.new
    file_upload_service.uuid = file_reference
    file_upload_service.upload(file_content: new_image, file_name: new_file_name)
  end

  def transform_image(bucket, extension, original_file)
    transformation_service = ImageFormatTransformationService.new
    transformation_service.format = extension
    transformation_service.image_blob = bucket.object(original_file).get.body
    transformation_service.convert
  end
end
