require "roda"
require "multi_json"

require "./lib/s3_handler"

class S3ArchiverApi < Roda
  plugin :indifferent_params
  plugin :json

  route do |r|
    r.post "upload" do
      request_json = MultiJson.load(request.body.read, symbolized_keys: true)

      # TODO: check if file exists
      filename = request_json["filename"]

      s3_handler.upload(ENV.fetch("AWS_BUCKET_NAME"), filename)

      request_json
    end

    r.post "delete" do
      request_json = MultiJson.load(request.body.read, symbolized_keys: true)
      filename = request_json["filename"]

      File.rename(filename, "#{filename}.deleted")

      { file: filename }
    end
  end

  def s3_handler
    @handler ||= S3Handler.new(
      region: ENV.fetch("AWS_REGION"),
      access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
      secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
    )
  end
end
