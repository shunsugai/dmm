require 'faraday'

module Faraday
  class Response::RaiseDmmError < Response::Middleware
    def on_complete(response)
      case response[:status]
      when 400
        raise Dmm::BadRequest,          error_message(response)
      when 401
        raise Dmm::Unauthorized,        error_message(response)
      when 403
        raise Dmm::Forbidden,           error_message(response)
      when 404
        raise Dmm::NotFound,            error_message(response)
      when 406
        raise Dmm::NotAcceptable,       error_message(response)
      when 422
        raise Dmm::UnprocessableEntity, error_message(response)
      when 500
        raise Dmm::InternalServerError, error_message(response)
      when 503
        raise Dmm::ServiceUnavailable,  error_message(response)
      end
    end

    private

    def error_message(response)
      return 'Response body not exists.' if response[:body].nil?
      message = response[:body]['error']
      return message unless message.empty?
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}"
    end
  end
end