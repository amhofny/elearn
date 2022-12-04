module RequestSpecHelper
  def json_response
    JSON.parse(response.body)
  end

  def set_content_type
    request.headers["Content-Type"] = "application/vnd.api+json"
  end
end
