Aws.config.update(
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
  region: 'eu-west-2'
)

BUCKET_NAME = ENV['BUCKET_NAME']
