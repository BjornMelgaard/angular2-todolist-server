class CustomFailure < Devise::FailureApp
  def respond
    if request.format.json?
      json_error_response
    else
      super
    end
  end

  def json_error_response
    self.status = :unauthorized
    self.content_type = "application/json"
    self.response_body = {
      error: "Login failed"
    }.to_json
  end

end
