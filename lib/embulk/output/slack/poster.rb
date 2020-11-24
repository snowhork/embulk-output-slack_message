module Embulk
  module Output
    module Slack
      class Poster
        class Error < StandardError;end
        class SlackPostError < Error;end
        
        def initialize(webhook_url, title)
          @title = title
          @conn = Faraday.new(url: webhook_url, headers: {'Content-Type' => 'application/json'}) do |builder|
            builder.request  :url_encoded
            builder.response :logger
            builder.adapter  :net_http
          end        
        end

        def post(hash)
          res = @conn.post do |req|
            req.body = {
              blocks: build_blocks(hash),
            }.to_json
          end

          p res.status
          p res.body if res.body

          raise SlackPostError.new(res.body) if p res.status != 200
        end

        private

        def build_blocks(hash)
          blocks = []
          if @title
            blocks << {
			  type: "section",
			  text: { type: "plain_text", text: @title }
		    }
          end

          blocks << {
            type: "section",
            fields: hash.map { |k, v| {type: "mrkdwn", text: "*#{k}* \n #{v}"} }
          }
        end
      end
    end
  end
end
