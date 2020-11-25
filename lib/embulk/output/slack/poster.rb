require 'erb'

module Embulk
  module Output
    module Slack
      class Poster
        class Error < StandardError;end
        class SlackPostError < Error;end

        def initialize(webhook_url, template_file)
          @conn = Faraday.new(url: webhook_url, headers: {'Content-Type' => 'application/json'}) do |builder|
            builder.request  :url_encoded
            builder.response :logger
            builder.adapter  :net_http
          end

          if template_file
            @template = File.read(template_file)
          end
        end

        def post_title(title)
          post({
              blocks: [{
                type: "section",
                text: { type: "mrkdwn", text: title },
              }],
            }.to_json)
        end

        def post_record(hash)
          post(@template ? apply_template(hash) : default_body(hash))
        end

        private

        def post(body)
          p body
          res = @conn.post do |req|
            req.body = body
          end

          p res.status
          p res.body if res.body

          raise SlackPostError.new(res.body) if p res.status != 200
        end

        def default_body(hash)
          {
            blocks: [{
              type: "section",
              fields: hash.map { |k, v| {type: "mrkdwn", text: "*#{k}* \n #{v}"} }
            }]
          }.to_json
        end

        def apply_template(hash)
          erb = ERB.new(@template)
          bind = binding

          hash.map do |k, v|
            bind.local_variable_set(k.to_sym, v)
          end

          erb.result(bind)
        end
      end
    end
  end
end
