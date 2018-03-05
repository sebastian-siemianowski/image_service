# frozen_string_literal: true

class FileUploadService
  def upload(file_content:, file_name:, extension:)
    uuid = SecureRandom.uuid
    bucket_name = 'rudph2xxximageservicexxxtest'
    s3 = Aws::S3::Resource.new(region:'eu-west-2')

    bucket = s3.bucket(bucket_name)
    data = Base64.decode64(file_content)

    original_file = bucket.object("images/#{uuid}/original/#{file_name}")
    original_file.put(body: data , acl: 'public-read')

    file_with_extension = bucket.object("images/#{uuid}/#{File.extname(file_name)}/#{file_name}")
    file_with_extension.put(body: data, acl: 'public-read')
    uuid
  end
end
