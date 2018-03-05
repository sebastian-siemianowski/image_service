# frozen_string_literal: true

class FileUploadService
  attr_accessor :uuid

  def upload(file_content:, file_name:)
    bucket_name = 'rudph2xxximageservicexxxtest'
    s3 = Aws::S3::Resource.new

    bucket = s3.bucket(bucket_name)
    data = Base64.decode64(file_content)

    if uuid
      file_with_extension = bucket.object("images/#{uuid}/#{File.extname(file_name)}/#{file_name}")
      file_with_extension.put(body: data, acl: 'public-read')
      uuid
    else
      new_uuid_key = SecureRandom.uuid unless uuid
      original_file = bucket.object("images/#{new_uuid_key}/original/#{file_name}")
      original_file.put(body: data, acl: 'public-read')

      file_with_extension = bucket.object("images/#{new_uuid_key}/#{File.extname(file_name)}/#{file_name}")
      file_with_extension.put(body: data, acl: 'public-read')
      new_uuid_key
    end
  end
end
