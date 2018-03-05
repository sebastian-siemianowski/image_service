# AWS.config(
#     :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
#     :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
# )

Aws.config.update(
    credentials: Aws::Credentials.new('AKIAIJJ2ILSXIT323I2A', '5ILyRK2TVOYyfWYvQR9wbMpeufqeaVh05Voy9D8G'),
    region: 'eu-west-2',
    )
