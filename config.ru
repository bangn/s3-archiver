if ENV["APP_ENV"] == "development"
  require "dotenv"

  Dotenv.load
end

require_relative "s3_archiver_api"

module Rack
  class Health
    PATH_INFO = "PATH_INFO"

    HEALTH_ENDPOINT = "/_health"
    OK = "200"

    HEADERS = { "Content-Type" => "text/plain" }

    #
    def initialize(app)
      @app = app
    end

    #
    def call(env)
      case env[PATH_INFO]
      when HEALTH_ENDPOINT
        [OK, HEADERS, [Time.now.to_s]]
      else
        @app.call(env)
      end
    end
  end
end

use Rack::Health

run S3ArchiverApi.freeze.app
