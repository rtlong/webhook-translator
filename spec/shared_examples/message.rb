shared_examples_for 'a Message' do
  [:source, :context, :subject, :body, :url, :email, :tags].each do |name|
    it { should respond_to(name) }
  end

  its(:source) { should be_a String }
  its(:context) { should be_a String }
  its(:subject) { should be_a String }
  its(:body) { should be_a String }
  its(:url) { should be_a String }
  its(:email) { should be_a String }
  its(:tags) { should be_a Array }
end

