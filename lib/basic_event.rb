class BasicEvent
  def initialize(attrs={})
    @attrs = Hashie::Mash.new(attrs)
  end

  [:source, :context, :subject, :body, :url, :email, :tags, :actor_name].each do |name|
    define_method name do
      @attrs[name]
    end
  end
end
