# frozen_string_literal: true

# AWS.config(
#     :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
#     :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
# )
#
#

Aws.config.update(
  credentials: Aws::Credentials.new('AKIAI7QJ4ZNI33FK2ZLQ', 'gez6FAHLn9Sw4OyRLkkvO634qYx8tF32AIuxCh/s'),
  region: 'eu-west-2'
)
