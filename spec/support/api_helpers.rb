module ApiHelpers
  def json_data
    body = JSON.parse(response.body).deep_symbolize_keys
    body[:data]
  end
end
