require 'fastlane/action'
require_relative '../helper/au_danger_gitlab_helper'

module Fastlane
  module Actions
    class AuDangerGitlabAction < Action
      def self.run(params)
        # UI.message("The au_danger_gitlab plugin is working!")
        remotes = sh("git ls-remote -q origin merge-requests\\*head|grep #{ENV['CI_COMMIT_SHA']}")
        match_data = /.*merge-requests\/([0-9]+)\//.match(remotes)
        if match_data && match_data[1]
          ENV['CI_MERGE_REQUEST_ID'] = match_data[1] 
          UI.message("Adding `CI_MERGE_REQUEST_ID` to ENVs")
          return true
        end

        UI.message("Not a merge request, exiting...")
        return false        
      end

      def self.description
        "Allows to use Danger on GitLab"
      end

      def self.authors
        ["SzymonMrozek", "emilwojtaszek"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "This plugin allows you to use Danger on GitLab by adding CI_MERGE_REQUEST_ID environment value"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "AU_DANGER_GITLAB_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
