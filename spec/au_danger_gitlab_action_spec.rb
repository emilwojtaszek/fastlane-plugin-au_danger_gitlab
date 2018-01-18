describe Fastlane::Actions::AuDangerGitlabAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The au_danger_gitlab plugin is working!")

      Fastlane::Actions::AuDangerGitlabAction.run(nil)
    end
  end
end
