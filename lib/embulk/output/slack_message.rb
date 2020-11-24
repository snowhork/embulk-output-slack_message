require 'faraday'
require_relative 'slack/poster'

module Embulk
  module Output
    class SlackMessage < OutputPlugin
      Plugin.register_output("slack_message", self)

      def self.transaction(config, schema, count, &control)
        # configuration code:
        task = {
          "webhook_url" => config.param("webhook_url", :string),
#          "option1" => config.param("option1", :integer),                     # integer, required
#          "option2" => config.param("option2", :string, default: "myvalue"),  # string, optional
#          "option3" => config.param("option3", :string, default: nil),        # string, optional
        }

        # resumable output:
        # resume(task, schema, count, &control)

        # non-resumable output:
        task_reports = yield(task)
        next_config_diff = {}
        return next_config_diff
      end

      # def self.resume(task, schema, count, &control)
      #   task_reports = yield(task)
      #
      #   next_config_diff = {}
      #   return next_config_diff
      # end

      def init
        @webhook_url = task["webhook_url"]
        @slack_poster = Slack::Poster.new(@webhook_url)
      end

      def close
      end

      def add(page)
        page.each do |record|
          hash = Hash[schema.names.zip(record)]
          @slack_poster.post("New App Arrival!", hash)
        end
      end

      def finish
      end

      def abort
      end

      def commit
        task_report = {}
        return task_report
      end
    end

  end
end
