require_relative 'spec_helper'

require 'semaphore'

describe Semaphore::BuildEvent do
  let(:attrs) do
    { # representative as of 9/15/2013
      branch_name: "master",
      branch_url: "https://semaphoreapp.com/projects/2501/branches/82167",
      project_name: "platform",
      build_url: "https://semaphoreapp.com/projects/2501/branches/82167/builds/3",
      build_number: 3,
      result: "failed",
      started_at: "2013-09-14T00:19:06Z",
      finished_at: "2013-09-14T00:19:10Z",
      commit: {
        id: "436eaaa85e3373d0d7e31f983a10cf7c42fa2cc8",
        url: "https://github.com/account/repo/commit/436eaaa85e3373d0d7e31f983a10cf7c42fa2cc8",
          author_name: "gh_user",
          author_email: "user@github.com",
          message: "Merge pull request #185",
          timestamp: "2013-09-14T00:14:11Z"
      }
    }
  end

  subject :event do
    Semaphore::BuildEvent.new attrs
  end

  it_behaves_like 'a Message'

  describe :subject do
    subject { event.subject }
    it { should match 'Build' }
    it('should include result') { should match attrs[:result] }
    it('should include branch name') { should match attrs[:branch_name] }
    it('should include build_number') { should match /##{attrs[:build_number]}/ }
  end
  describe :result do
    subject { event.result }
    it('should be a StringInquirer') { should be_a(ActiveSupport::StringInquirer) }
    it('should be tied to input "result"') { should be_failed }
  end
  describe :body do
    subject { event.body }
    it('should include project name') { should match attrs[:project_name] }
    it('should include branch name') { should match attrs[:branch_name] }
    it('should include commit SHA') { should match attrs[:commit][:id][0..6] }
    it('should include commit message') { should match attrs[:commit][:message] }
    it('should include commit author') { should match attrs[:commit][:author_name] }
    it('should include build_number') { should match /##{attrs[:build_number]}/ }
  end
  describe :url do
    subject { event.url }
    it('should be the build_url') { should eq attrs[:build_url] }
  end
  describe :email do
    subject { event.email }
    it('should be the commit author_email') { should eq attrs[:commit][:author_email] }
  end
  describe :context do
    subject { event.context }
    it('should be the project_name') { should eq attrs[:project_name] }
  end
  describe :tags do
    subject { event.tags }
    it('should include #build') { should include 'build' }
    it('should include the project_name') { should include attrs[:project_name] }
    it('should include the branch_name') { should include attrs[:branch_name] }
  end
  describe :source do
    subject { event.source }
    it('should be "Semaphore"') { should eq 'Semaphore' }
  end
end

describe Semaphore::DeployEvent do
  let(:attrs) do
    { # representative as of 9/15/2013
      project_name: "platform",
      server_name: "Platform Staging",
      number: 36,
      result: "failed",
      created_at: "2013-09-12T15:09:22-07:00",
      updated_at: "2013-09-12T15:09:29-07:00",
      started_at: "2013-09-12T15:09:24-07:00",
      finished_at: "2013-09-12T15:09:29-07:00",
      html_url: "https://semaphoreapp.com/projects/2501/servers/71/deploys/36",
      build_html_url: nil,
      commit:  {
        id: "56ea2b077e8455a10a4b339d453debf94762f23b",
        url:  "https://github.com/GoodGuide/platform/commit/56ea2b077e8455a10a4b339d453debf94762f23b",
        author_name: "Joshua Bates",
        author_email: "joshuabates@gmail.com",
        message:  "Merge pull request #182 from GoodGuide/feature.hide_import_button_from_non_admins\n\nshow import button only to admins and superusers",
        timestamp: "2013-09-12T13:55:48-07:00"
      }
    }
  end

  subject :event do
    Semaphore::DeployEvent.new attrs
  end

  it_behaves_like 'a Message'

  describe :subject do
    subject { event.subject }
    it { should match 'Deploy' }
    it('should include result') { should match attrs[:result] }
    it('should include server_name') { should match attrs[:server_name] }
    it('should include number') { should match /##{attrs[:number]}/ }
  end
  describe :result do
    subject { event.result }
    it('should be a StringInquirer') { should be_a(ActiveSupport::StringInquirer) }
    it('should be tied to input "result"') { should be_failed }
  end
  describe :body do
    subject { event.body }
    it('should include server_name') { should match attrs[:server_name] }
    it('should include commit SHA') { should match attrs[:commit][:id][0..6] }
    it('should include commit message') { should match attrs[:commit][:message] }
    it('should include commit author') { should match attrs[:commit][:author_name] }
    it('should include number') { should match /##{attrs[:number]}/ }
  end
  describe :url do
    subject { event.url }
    it('should be the html_url') { should eq attrs[:html_url] }
  end
  describe :email do
    subject { event.email }
    it('should be the commit author_email') { should eq attrs[:commit][:author_email] }
  end
  describe :context do
    subject { event.context }
    it('should be the project_name') { should eq attrs[:project_name] }
  end
  describe :tags do
    subject { event.tags }
    it('should include #deploy') { should include 'deploy' }
    it('should include the project_name') { should include attrs[:project_name] }
    it('should include the server_name') { should include attrs[:server_name] }
  end
  describe :source do
    subject { event.source }
    it('should be "Semaphore"') { should eq 'Semaphore' }
  end
end
