# AWS.config(
#     :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
#     :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
# )

Aws.config.update(
    credentials: Aws::Credentials.new('AKIAJ3QPJUFTJ43CNTQQ', 'yraWIGa3YUz/dm8G9hfzsmFuUcyec9yuNgMI3xq7'),
    region: 'eu-west-2',
    )
