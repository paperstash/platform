module PaperStash
  Error = Class.new(::StandardError)

  module OAuth2
    Error = Class.new(PaperStash::Error)

    class UnsafeRedirect < Error
      attr_reader :redirect
      def initialize(redirect)
        super "Cannot redirect to '#{redirect}' as it would be unsafe."
        @redirect = redirect
      end
    end

    class InvalidScope < Error
      attr_reader :grants
      def initialize(grants)
        super "Unknown grants in requested scope."
        @grants = grants
      end
    end

    # TODO(mtwilliams): Provide descriptive messages.
    IncorrectClientSecret = Class.new(Error)
    IncorrectState = Class.new(Error)
  end
end

# "".inquiry rather than ActiveSupport::StringInquirer.new(...)

# HEADERS = {'Content-Type' => 'application/json'}
# grants_as_sentence = grants.map{|grant| "'#{grant}'"}.to_sentence

# error OAuth2::UnsafeRedirect do
#   halt [400, HEADERS, [{error: {type: 'oauth2_unsafe_redirect', message: env['sinatra.error'].message}}.to_json]]
# end

# error OAuth2::InvalidScope do
#   # TODO(mtwilliams): Use string distance to suggest the correct scope(s)?
#   halt [400, HEADERS, [{error: {type: 'oauth2_invalid_scope', message: env['sinatra.error'].message, details: {grants: env['sinatra.error'].grants}}}.to_json]]
# end

# set :raise_sinatra_param_exceptions, true

# error Sinatra::Param::InvalidParameterError do
#   param = env['sinatra.error'].param
#   reason = env['sinatra.error'].message
#   halt [400, HEADERS, [{error: {type: 'invalid_parameters', message: env['sinatra.error'].message, details: {param => reason}}.to_json])
# end

# error Sequel::Error do
#   case env['sinatra.error']
#     when Sequel::ConstraintViolation
#       halt [400, HEADERS, [{error: {type: 'invalid_parameters', message: env['sinatra.error'].message, details: env['sinatra.error'].errors}}.to_json]]
#     when Sequel::NoMatchingRow
#       halt [404, HEADERS, [{error: 'does_not_exist', message: env['sinatra.error'].message}.to_json]]
#     else
#       halt [500, HEADERS, [{error: 'unknown'}.to_json]]
#   end
# end
