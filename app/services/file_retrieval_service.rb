class FileRetrievalService
  def retrieve(file_reference, extension = nil)
    s3 = Aws::S3::Resource.new
    bucket_name = 'rudph2xxximageservicexxxtest'

    bucket = s3.bucket(bucket_name)

    if extension.nil?
      file = bucket.objects(prefix: "images/#{file_reference}/original/").collect(&:key).first
    else
      file = bucket.objects(prefix: "images/#{file_reference}/.#{extension}/").collect(&:key).first
    end

    puts file
    puts object = bucket.object(file)
    object = bucket.object(file).get
        object.body

    object.body
  end
end