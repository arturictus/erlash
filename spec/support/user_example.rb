
class User
  def email
    "mail@example.com"
  end
  def id; 1 end
  def errors
    "email already token"
  end
end

class Erlash::UserFormatter < Erlash::TemplateFormatter
  def format
    format_elem({
      id: object.id,
      email: object.email
    })
  end
end

Erlash.formatters.register(User, Erlash::UserFormatter)

class RequestError < Erlash::Base
  problem "User is unable to update his email"
  sumary do |context|
    "Validation errors: #{context[:user].errors}"
  end
end
