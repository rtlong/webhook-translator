module JsonIO
  def parse_request_body_as_json(options={})
    request.body.rewind
    MultiJson.load(request.body.read, options)
  end
end
