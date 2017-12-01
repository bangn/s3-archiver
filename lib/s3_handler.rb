require "aws-sdk-s3"

class S3Handler
  def initialize(config)
    Aws.config.update(config)
    @s3 = Aws::S3::Resource.new
  end

  def upload(bucket, filename)
    file = File.basename(filename)
    s3_obj = @s3.bucket(bucket).object(file)
    s3_obj.upload_file(filename)
  end
end
