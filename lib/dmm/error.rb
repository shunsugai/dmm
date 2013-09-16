module Dmm
  class Error < StandardError; end
  class BadRequest < Error; end # 400
  class Unauthorized < Error; end # 401
  class Forbidden < Error; end # 403
  class NotFound < Error; end # 404
  class NotAcceptable < Error; end # 406
  class UnprocessableEntity < Error; end # 422
  class InternalServerError < Error; end # 500
  class ServiceUnavailable < Error; end # 503
end