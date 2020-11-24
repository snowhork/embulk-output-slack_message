module Embulk
  module Output
    module Slack
      class Poster
        class Error < StandardError;end
        class SlackPostError < Error;end
        
        def initialize(webhook_url)
          @conn = Faraday.new(url: webhook_url, headers: {'Content-Type' => 'application/json'}) do |builder|
            builder.request  :url_encoded
            builder.response :logger
            builder.adapter  :net_http
          end        
        end

        def post(title, hash)
          res = @conn.post do |req|
            req.body = {
              text: title,
              blocks: [
		        {
			      type: "section",
			      text: { type: "plain_text", text: title, }
		        },                
                {
                  type: "section",
                  fields: hash.map { |k, v| {type: "mrkdwn", text: "*#{k}* \n #{v}"} }
                },
              ]
            }.to_json
          end

          p res.status
          p res.body if res.body

          raise SlackPostError.new(res.body) if p res.status != 200
        end
      end
    end
  end
end
