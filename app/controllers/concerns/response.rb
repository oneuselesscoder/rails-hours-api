module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def invalid_data(object)
    render json: object, status: 417
  end
end